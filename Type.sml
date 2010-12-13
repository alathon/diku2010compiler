structure Type :> Type =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  type pos = int*int

  (** A striped datatype for the types of expressions. **)
  datatype Type = Int | Bool | TyVar of string

  (**
  * Lookup the value of some symbol in some symbol table.
  **)
  fun lookup needle [] = NONE
    | lookup needle ((key, value, _) :: haystack) =
        if needle = key then SOME value else lookup needle haystack

  (**
  * Strip extra type information returned from the parser.
  **)
  fun stripType x =
    case x of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar (name, _) => TyVar(name)

  (* Check pattern and return vtable *)
  fun checkPat [] [] _ _ vtable = vtable
    | checkPat [] _ _ pos _ = raise Error ("Pattern too short for tuple", pos)
    | checkPat _ [] _ pos _ = raise Error ("Tuple too short for pattern", pos)
    | checkPat (pat::pats) (ty::tys) ttable pos vtable =
    let val rest = checkPat pats tys ttable pos vtable in
    (case (pat,ty) of
      (Cat.NumP _, Int) => rest
    | (Cat.TrueP _, Bool) => rest
    | (Cat.FalseP _, Bool) => rest
    | (Cat.NullP _, Null) => rest
    | (Cat.VarP (name,p), tyvar) => 
        let
          val x = 
            (case (lookup name vtable) of
               SOME _ => raise Error ("Duplicate definition", p)
             | NONE => ())
          val value = (name, tyvar, p)
         in
           (x; (value :: (checkPat pats tys ttable pos (value :: vtable))))
         end
    | (Cat.TupleP (plist, p), TyVar(name))  =>
        let val tupletys = 
          (case (lookup name ttable) of 
             SOME x => List.map stripType x
           | NONE => raise Error ("Undefined type "^name, p))
        in
          (checkPat plist tupletys ttable pos vtable) @ rest
        end
    | _ => raise Error ("Pattern doesn't match type", pos)
    )
    end

  (* Type-checks an expression, returns it's type. *)
  fun checkExp exp vtable ftable ttable =
  let 
    fun shortCheckExp e = checkExp e vtable ftable ttable 
    fun binIntOperator (e1, e2, xy) strOperator rtype = 
      (case (shortCheckExp e1, shortCheckExp e2) of (Int,Int) => rtype
       | _ => raise Error ("Non-int argument for " ^ strOperator, xy))
    fun shortLookup (name, xy) table strType =
      (case lookup name table of SOME value => value
       | _ => raise Error ("Unbound " ^ strType ^ ":" ^ name, xy))
  in
    case (exp) of
      Cat.Num   _ => Int
    | Cat.Read  _ => Int
    
    | Cat.True  _ => Bool
    | Cat.False _ => Bool
    | Cat.Not   _ => Bool
    | Cat.And   _ => Bool
    | Cat.Or    _ => Bool
    
    | Cat.Less  x => binIntOperator x "<" Bool
    | Cat.Equal x => binIntOperator x "=" Bool
    | Cat.Plus  x => binIntOperator x "+" Int
    | Cat.Minus x => binIntOperator x "-" Int

    | Cat.Var   x => shortLookup x vtable "variable" 
    
    | Cat.Null (name, xy) => 
        (case (lookup name ttable) of SOME _ => TyVar(name)
         | _ => raise Error ("Unbound type:" ^ name, xy))

    | Cat.MkTuple (explist, tyname, pos) =>
      let
        val tylist = shortLookup (tyname, pos) ttable "type"

        fun iter (t::ts) (e::es) pos =
            if (stripType t) = (shortCheckExp e)
              then iter ts es pos
            else 
              raise Error("Tuple type mismatch", pos)
          | iter [] (e::es) pos =
              raise Error("Too many expressions for tuple", pos)
          | iter (t::ts) [] pos =
              raise Error("Too few expressions for tuple", pos)
          | iter [] [] pos = ()

        val _ = iter tylist explist pos 
     in
         TyVar(tyname)
      end

    | Cat.If (e1,e2,e3,pos) =>
      let
        val v1 = shortCheckExp e1
        val v2 = shortCheckExp e2
        val v3 = shortCheckExp e3
      in
        if v2 <> v3 then raise Error ("Incompatible types", pos)
        else if v1 <> Bool then raise Error ("Non-boolean expression", pos)
        else v2
      end
    | Cat.Case (exp, matches, pos) => 
        checkMatches matches (shortCheckExp exp) vtable ftable ttable pos
    
    | Cat.Let ([], e, _) => shortCheckExp e
    | Cat.Let (((dp, de, dpos) :: decs), exp, pos) =>
        shortCheckExp (Cat.Case (de, [(dp, Cat.Let(decs, exp, pos))], dpos))

    | Cat.Apply (name, e, xy) =>
       (case lookup name ftable of SOME (atype, rtype) =>
	          if atype = (shortCheckExp e) then rtype
            else raise Error (
            "Argument does not match declaration of " ^ name, xy)
        | _ => raise Error ("Unknown function " ^ name, xy))
    | Cat.Write (e, xy) =>
       (case (shortCheckExp e) of Int => Int
        | _ => raise Error ("Non-int argument to write", xy))
    end
  and checkMatches [(p,e)] tce vtable ftable ttable pos =
        let
          val vtable1 = checkPat [p] [tce] ttable pos vtable
        in
	        checkExp e (vtable1 @ vtable) ftable ttable
        end
    | checkMatches ((p,e)::ms) tce vtable ftable ttable pos =
        let
          val vtable1 = checkPat [p] [tce] ttable pos vtable
          val te = checkExp e (vtable1 @ vtable) ftable ttable
          val tm = checkMatches ms tce vtable ftable ttable pos
        in
	  if te = tm then te
	  else raise Error ("Match branches have different type",pos)
        end
    | checkMatches [] tce vtable ftable ttable pos =
        raise Error ("Empty match", pos)

  (**
  * Auxiliary function for duplicates checking in a table. 
  **)
  fun checkForDuplicate key haystack strType xy func =
      (case (List.find (fn (x, _, _)=> x = key) haystack) of
           SOME (_, _, (x, y)) => raise Error (
              "The " ^ strType ^ " " ^ key ^ " is already declared at line " ^
              Int.toString(x) ^ " column " ^ Int.toString(y) ^
              ". Attempted duplicate declaration", xy)
         | NONE => func
        )

  (**
  * Puts the type declarations into ttable. 
  * Raises an error if some type is declared more than once.
  **)
  fun getTyDecs [] ttable = ttable
    | getTyDecs ((name, tylist, xy) :: tydecs) ttable =
        checkForDuplicate name ttable "type" xy
        (getTyDecs tydecs ((name, tylist, xy) :: ttable))
        
  (**
  * Puts the function declarations into ftable. 
  * Raises an error if some function is declared more than once.
  **)
  fun getFunDecs [] ftable = ftable
    | getFunDecs ((name, atype, rtype, _, xy) :: fundecs) ftable =
        checkForDuplicate name ftable "function" xy
        (getFunDecs fundecs 
          ((name, (stripType atype, stripType rtype), xy) :: ftable))

  (**
  * Type-checks the declared functions. Both ftable and ttable
  * must be gathered beforehand. 
  **)
  fun checkFunDec ftable ttable (_, atype, rtype, matches, xy) =
    let
      val atype = stripType atype
      val rtype = stripType rtype 
      val btype = checkMatches matches atype [] ftable ttable xy
    in
      if rtype = btype then rtype
      else raise Error ("Body type doesn't match declaration", xy)
    end

  (**
  * Type-checks the entire program text. 
  **)
  fun checkProgram (tyDecs, funDecs, e) =
    let
      val ttable = getTyDecs tyDecs []
      val ftable = getFunDecs funDecs []
      val _ = List.map (checkFunDec ftable ttable) funDecs
    in
      (checkExp e [] ftable ttable; ())
    end
end
