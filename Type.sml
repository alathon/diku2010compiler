structure Type :> Type =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  type pos = int*int

  datatype Type = Int | Bool | TyVar of string

  (* lookup function for symbol table as list of (name,value) pairs *)
  fun lookup x []
        = NONE
    | lookup x ((y,v)::table)
        = if x=y then SOME v else lookup x table

  (* combine two symbol tables and check for duplicates *)
  fun combineTables [] table2 p = table2
    | combineTables ((x,v)::table1) table2 p =
        case lookup x table2 of
          SOME _ => raise Error ("Repeated identifier "^x,p)
        | NONE => (x,v) :: combineTables table1 table2 p

  (* check that type expression is valid and return its type *)
  fun checkType te ttable =
    case te of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar x => TyVar(#1 x)
    | _ => raise Error("checkType failed", (1,1))

  (* Check pattern and return vtable *)
  fun checkPat pat ty ttable pos =
    case (pat,ty) of
      (Cat.NumP _, Int) => []
    | (Cat.TrueP _, Bool) => []
    | (Cat.FalseP _, Bool) => []
    | (Cat.NullP _, Null) => []
    | (Cat.VarP (x,p), ty) => [(x,ty)]
    | _ => raise Error ("Pattern doesn't match type", pos)

(*
  fun checkPatType pat ty =
    case pat of
      Cat.NumP _ => 
        if ty = Int then true else raise Error("",pos)
    | Cat.TrueP _ => 
        if ty = Bool then true else raise Error("", pos)
    | Cat.FalseP _ =>
        if ty = Bool then true else raise Error("", pos)
    | Cat.TupleP  =>
        if
    (* | Cat.NullP _ => Null *)
    | Cat.TupleP _ => Tuple
    | Cat.VarP _ => ty
    | _ => raise Error ("Unknown pattern", pos)
*)

  (* check expression and return type *)
  fun checkExp exp vtable ftable ttable =
    case exp of
      Cat.Num (n,pos) => Int
    | Cat.True (n,pos) => Bool
    | Cat.False (n,pos) => Bool
    | Cat.Null (n,pos) => (case lookup n ttable of
          SOME t => TyVar(n)
        | _      => raise Error ("Unknown type: "^n,pos))
    | Cat.Var (x,pos) =>
       (case lookup x vtable of
	  SOME t => t
        | NONE => raise Error ("Unknown variable "^x,pos))

    | Cat.MkTuple (explist, tyname, pos) =>
      let
        val tylist2 = 
          (case (lookup tyname ttable) of
             SOME i => i
           | _ => raise Error("nice",pos))
 
        fun conv (Cat.Bool _) = Bool
          | conv (Cat.Int _) = Int
          | conv _ = raise Error("Lala", pos)

        fun iter (t::tylist) (e::explist) pos =
          if conv t = checkExp e vtable ftable ttable
            then iter tylist explist pos
          else 
            raise Error("OHMAHGAWD", pos)
          | iter [] (e::explist) pos =
            raise Error("OHMAHGAWD 1", pos)
          | iter (t::tylist) [] pos =
            raise Error("OHMAHGAWD 2", pos)
          | iter [] [] pos = ()

        val _ = iter tylist2 explist pos
          
     in
         TyVar(tyname)
      end


    | Cat.Less (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Bool
        | _ => raise Error ("Non-int argument to <",pos))
 
    | Cat.Equal (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Bool
        | _ => raise Error ("Non-int argument to =",pos))
    
    | Cat.If (e1,e2,e3,pos) =>
      let
        val v1 = checkExp e1 vtable ftable ttable
        val v2 = checkExp e2 vtable ftable ttable
        val v3 = checkExp e3 vtable ftable ttable
      in
        if v2 <> v3 then raise Error ("Incompatible types", pos)
        else if v1 <> Bool then raise Error ("Non-boolean expression", pos)
        else Bool
      end
(*
    | Cat.Case (exp, matches, pos) => 
      (let
        val (m1::m1s) = matches
        val ety1 = checkExp (#2 m1) vtable ftable ttable
        fun checkMatch ty (p, e) =
          let
            val ety = checkExp e vtable ftable ttable
          in
            if ety1 = ety andalso checkPat p = ty then ty1 
            else raise Error("pattern fail", pos)
          end
      in
        List.nth(1, List.map (checkMatch (checkExp exp vtable ftable ttable)) matches)
      end)
    | Cat.Case (exp,[],pos) => 
      raise Error("No matches in case",pos)
*)
    | Cat.Not (e1,pos) => Bool
    | Cat.And (e1,e2,pos) => Bool
    | Cat.Or (e1,e2,pos) => Bool

    | Cat.Plus (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Int
        | _ => raise Error ("Non-int argument to +",pos))
    
    | Cat.Minus (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Int
        | _ => raise Error ("Non-int argument to -",pos))
    | Cat.Apply (f,e1,pos) =>
       (case lookup f ftable of
	  SOME (t1,t2) =>
	    if t1 = (checkExp e1 vtable ftable ttable)
            then t2
            else raise Error ("Argument does not match declaration of "^f,pos)
        | _ => raise Error ("Unknown function "^f,pos))
    | Cat.Read (n,pos) => Int
    | Cat.Write (e1,pos) =>
       (case checkExp e1 vtable ftable ttable of
          Int => Int
        | _ => raise Error ("Non-int argument to write",pos))
    | _ => raise Error("Expression fail", (1,1))

  and checkMatch [(p,e)] tce vtable ftable ttable pos =
        let
          val vtable1 = checkPat p tce ttable pos
        in
	  checkExp e (vtable1 @ vtable) ftable ttable
        end
    | checkMatch ((p,e)::ms) tce vtable ftable ttable pos =
        let
          val vtable1 = checkPat p tce ttable pos
          val te = checkExp e (vtable1 @ vtable) ftable ttable
          val tm = checkMatch ms tce vtable ftable ttable pos
        in
	  if te = tm then te
	  else raise Error ("Match branches have different type",pos)
        end
    | checkMatch [] tce vtable ftable ttable pos =
        raise Error ("Empty match",pos)

  fun getTyDecs [] ftable = ftable
    | getTyDecs ((ty, tylist, pos)::fs) ftable =
        if List.exists (fn (g,_)=>ty=g) ftable
	then raise 
          Error ("Duplicate declaration of function "^ty,pos)
        else getTyDecs fs
	    ((ty, tylist) :: ftable)


  fun getFunDecs [] ttable ftable = ftable
    | getFunDecs ((f, targ, tresult, m, pos)::fs) ttable ftable =
        if List.exists (fn (g,_)=>f=g) ftable
	then raise Error ("Duplicate declaration of function "^f,pos)
        else getFunDecs fs ttable
			((f, (checkType targ ttable, checkType tresult ttable))
			 :: ftable)

  fun checkFunDec ftable ttable (f, targ, tresult, m, pos) =
    let
      val argtype = checkType targ ttable
      val resulttype = checkType tresult ttable
      val bodytype = checkMatch m argtype [] ftable ttable pos
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
