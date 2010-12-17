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
  fun stripType ty =
    case ty of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar (name, _) => TyVar(name)

  (**
  * Strip extra type information returned from the parser.
  * In case of tyvar check that the type is declared in ttable.
  **)
  fun checkType ttable xy ty =
    (case (stripType ty) of
       TyVar (name) => 
        (case (lookup name ttable) of 
           SOME _ => TyVar (name) 
         | _ => raise Error ("Undefined type " ^ name, xy)
        )
     | value => value
    )

  (** 
  * Check pattern and return vtable.
  * Recursive calls are only made in case of tuples,
  * empty Pat lists and Type lists are not permissible
  * by the grammar.
  **)
  fun checkPat [] [] _ vtable _  = vtable
    | checkPat [] _ _ _ xy = raise Error ("Pattern too short for tuple", xy)
    | checkPat _ [] _ _ xy = raise Error ("Tuple too short for pattern", xy)
    | checkPat (pat::pats) (ty::tys) ttable vtable xy =
    let val rest = checkPat pats tys ttable vtable xy in
    (case (pat,ty) of
      (Cat.NumP _, Int)     => rest
    | (Cat.TrueP _, Bool)   => rest
    | (Cat.FalseP _, Bool)  => rest
    | (Cat.NullP nxy, TyVar(name))   =>
        let
          val _ = 
          (case (lookup name ttable) of SOME x => x
           | _ => raise Error ("Undefined type " ^ name, nxy)
          )
        in
          rest
        end        
    | (Cat.VarP (name, p), tyvar) => 
        let
          val value = (name, tyvar, p)
         in
           (value :: (checkPat pats tys ttable (value :: vtable) xy))
         end
    | (Cat.TupleP (plist, p), TyVar(name))  =>
        let val tupletys = 
          (case (lookup name ttable) of 
             SOME x => List.map stripType x
           | NONE => raise Error ("Undefined type "^name, p))
        in
          (checkPat plist tupletys ttable vtable xy) @ rest
        end
    | _ => raise Error ("Pattern doesn't match type", xy)
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

      | Cat.Not   (x,xy) => 
          if shortCheckExp x <> Bool 
            then raise Error("Non-bool argument to not operator", xy)
            else Bool
      | Cat.And   (e1, e2, xy) =>
          if shortCheckExp e1 <> Bool orelse shortCheckExp e2 <> Bool
            then raise Error("Non-bool argument to and operator", xy)
            else Bool
      | Cat.Or    (e1, e2, xy) =>
          if shortCheckExp e1 <> Bool orelse shortCheckExp e2 <> Bool
            then raise Error("Non-bool argument to or operator", xy)
            else Bool
    
      | Cat.Less  x => binIntOperator x "<" Bool
      | Cat.Equal x => binIntOperator x "=" Bool
      | Cat.Plus  x => binIntOperator x "+" Int
      | Cat.Minus x => binIntOperator x "-" Int

      | Cat.Var   x => shortLookup x vtable "variable" 
    
      | Cat.Null (name, xy) => 
          (case (lookup name ttable) of SOME _ => TyVar(name)
           | _ => raise Error ("Unbound type:" ^ name, xy))

      | Cat.MkTuple (explist, tyname, xy) =>
        let
          val tylist = shortLookup (tyname, xy) ttable "type"

          fun iter (t::ts) (e::es) xy =
            if (stripType t) = (shortCheckExp e)
              then iter ts es xy
            else 
              raise Error("Tuple type mismatch", xy)
          | iter [] (e::es) xy =
              raise Error("Too many expressions for tuple", xy)
          | iter (t::ts) [] xy =
              raise Error("Too few expressions for tuple", xy)
          | iter [] [] xy = () 
        in
          (iter tylist explist xy;TyVar(tyname))
        end

      | Cat.If (e1, e2, e3, xy) =>
        let
          val v2 = shortCheckExp e2
          val v3 = shortCheckExp e3
          (* Make sure if exp isn't a tuple. *)
        in
          if v2 <> v3 then raise Error ("Incompatible types", xy)
          else if v2 <> Bool then raise Error ("Non-bool type in if statement", xy)
          else Bool
        end

      | Cat.Case (exp, matches, xy) => 
          checkMatches matches (shortCheckExp exp) vtable ftable ttable xy
    
      | Cat.Let ([], e, _) => shortCheckExp e
      | Cat.Let (((dp, de, dxy) :: decs), exp, xy) =>
          shortCheckExp (Cat.Case (de, [(dp, Cat.Let(decs, exp, xy))], dxy))

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

  (**
  * Type-checks a match collection. All patterns must be compatible
  * with the type of the input argument (tce). Also, all match expressions
  * must be of the type, it is this type that is returned.
  **)
  and checkMatches [(p, e)] atype vtable ftable ttable xy =
        let val pvtable = checkPat [p] [atype] ttable vtable xy
        in checkExp e (pvtable @ vtable) ftable ttable end
    | checkMatches ((p, e) :: matches) atype vtable ftable ttable xy =
        let
          val pvtable = checkPat [p] [atype] ttable vtable xy
          val te = checkExp e (pvtable @ vtable) ftable ttable
          val tm = checkMatches matches atype vtable ftable ttable xy
        in
	        if te = tm then te
	        else raise Error ("Match branches have different type", xy)
        end
    | checkMatches [] _ _ _ _ xy =
        raise Error ("Match patterns absent", xy)

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
  fun checkProgram (tyDecs, funDecs, exp) =
    let
      val ttable = getTyDecs tyDecs []
      val _ = List.map (fn (_, tys, xy) => List.map (checkType ttable xy) tys) ttable
      val ftable = getFunDecs funDecs []
      val _ = List.map (checkFunDec ftable ttable) funDecs
    in
      (checkExp exp [] ftable ttable; ())
    end
end
