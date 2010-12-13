structure Type :> Type =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  type pos = int*int

  datatype Type = Int | Bool | TyVar of string

  (* lookup function for symbol table as list of (name,value) pairs *)
  fun lookup needle [] = NONE
    | lookup needle ((key, value) :: haystack) =
        if needle = key then SOME value else lookup needle haystack

  (* combine two symbol tables and check for duplicates *)
  fun combineTables [] table2 p = table2
    | combineTables ((x,v)::table1) table2 p =
        case lookup x table2 of
          SOME _ => raise Error ("Repeated identifier "^x,p)
        | NONE => (x,v) :: combineTables table1 table2 p

  (* check that type expression is valid and return its type *)
  fun checkType te =
    case te of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar (name, _) => TyVar(name)
    | _ => raise Error("checkType failed", (1,1))

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
          val x = (case (lookup name vtable) of
                     SOME _ => raise Error ("Duplicate definition", p)
                   | NONE => ())
         in
           (x;(name, tyvar) :: (checkPat pats tys ttable pos ((name,
           tyvar)::vtable)))
         end
    | (Cat.TupleP (plist, p), TyVar(name))  =>
        let val tupletys = 
          (case (lookup name ttable) of SOME v => List.map checkType v
           | NONE => raise Error ("Undefined type "^name, p))
        in
          (checkPat plist tupletys ttable pos vtable) @ rest
        end
    | _ => raise Error ("Pattern doesn't match type", pos)
    )
    end

  (* check expression and return type *)
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
            if (checkType t) = (shortCheckExp e)
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

    | Cat.Apply (f,e1,pos) =>
       (case lookup f ftable of
	  SOME (t1,t2) =>
	    if t1 = (checkExp e1 vtable ftable ttable)
            then t2
            else raise Error ("Argument does not match declaration of "^f,pos)
        | _ => raise Error ("Unknown function "^f,pos))
    | Cat.Read  _ => Int
    | Cat.Write (e, xy) =>
       (case (shortCheckExp e) of Int => Int
        | _ => raise Error ("Non-int argument to write", xy))
    | _ => raise Error("Expression fail", (1,1))
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
        raise Error ("Empty match",pos)

  fun getTyDecs [] ftable = ftable
    | getTyDecs ((ty, tylist, pos)::fs) ftable =
        if List.exists (fn (g,_)=>ty=g) ftable
	      then raise 
          Error ("Duplicate declaration of type "^ty,pos)
        else getTyDecs fs ((ty, tylist) :: ftable)


  fun getFunDecs [] ttable ftable = ftable
    | getFunDecs ((f, targ, tresult, m, pos)::fs) ttable ftable =
        if List.exists (fn (g,_)=>f=g) ftable
	then raise Error ("Duplicate declaration of function "^f,pos)
        else getFunDecs fs ttable
			((f, (checkType targ, checkType tresult))
			 :: ftable)

  fun checkFunDec ftable ttable (f, targ, tresult, m, pos) =
    let
      val argtype = checkType targ
      val resulttype = checkType tresult 
      val bodytype = checkMatches m argtype [] ftable ttable pos
    in
      if resulttype = bodytype
      then resulttype
      else raise Error ("Body type doesn't match declaration",pos)
    end

  fun checkProgram (tyDecs, funDecs, e) =
    let
      val ttable = getTyDecs tyDecs []
      val ftable = getFunDecs funDecs ttable []
      val _ = List.map (checkFunDec ftable ttable) funDecs
    in
      (checkExp e [] ftable ttable; ())
    end
end
