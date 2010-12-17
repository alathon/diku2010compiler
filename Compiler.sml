(* Compiler for Cat *)
(* Compile by mosmlc -c Compiler.sml *)
(* Then recompile CC by mosmlc CC.sml -o CC *)

structure Compiler :> Compiler =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

 (** A striped datatype for the types of expressions. **)
  datatype Type = Int | Bool | TyVar of string

  (**
  * Strip extra type information returned from the parser.
  **)
  fun stripType x =
    case x of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar (name, _) => TyVar(name)

  (* Name generator.  Call with, e.g., t1 = "tmp"^newName () *)
  val counter = ref 0

  fun newName () = (counter := !counter + 1;
                  "_" ^ Int.toString (!counter)^ "_")

  (* Number to text with spim-compatible sign symbol *)
  fun makeConst n = if n>=0 then Int.toString n
                    else "-" ^ Int.toString (~n)

  fun lookup x [] pos = raise Error ("Name "^x^" not found", pos)
    | lookup x ((y,v)::table) pos = if x=y then v else lookup x table pos

  fun lookup2 x [] pos = raise Error ("Name "^x^" not found", pos)
    | lookup2 x ((y,v,_)::table) pos = if x=y then v else lookup2 x table pos

  fun isIn x [] = false
    | isIn x (y::ys) = x=y orelse isIn x ys

  (* link register *)
  val RA = "31"
  (* Register for stack pointer *)
  val SP = "29"
  (* Register for heap pointer *)
  val HP = "28"

  (* Suggested register division *)
  val maxCaller = 15   (* highest caller-saves register *)
  val maxReg = 26      (* highest allocatable register *)

  (* compile pattern *)
  fun compilePat p v vtable fail offset =
    case p of
      Cat.NumP (n,pos) =>
        let
	        val t = "_constPat_"^newName()
        in
          if n < 32768 then
	          ([
              Mips.LI (t, makeConst n),
	            Mips.BNE (v,t,fail)
             ], vtable)
	        else
	          ([
              Mips.LUI (t, makeConst (n div 65536)),
	            Mips.ORI (t, t, makeConst (n mod 65536)),
	            Mips.BNE (v,t,fail)
             ], vtable)
	      end
    | Cat.VarP (x,pos) =>
        let
          val xt = "_patVar_"^x^"_"^newName()
        in
          ([Mips.MOVE (xt,v), Mips.COMMENT "hej"], (x,xt)::vtable)
        end

    | Cat.FalseP (n,pos) =>
      let
        val t = "_falsePat_"^newName()
      in
        ([Mips.LI (t, makeConst 0), 
          Mips.BNE (v,t,fail)], 
          vtable)
      end

    | Cat.TrueP (n, _) =>
      let
        val t = "_truePat_"^newName()
      in
        ([Mips.LI (t, makeConst ~1), 
          Mips.BNE (v, t, fail)], 
          vtable)
      end

    | Cat.NullP _ =>
       ([Mips.BNE (v, "0", fail)], vtable)

    | Cat.TupleP (plist, pos) => 
      let
        val ta = "_ta" ^ newName ()
        fun iter [] myvtable _ sp = ([], myvtable)
          | iter (pat :: pats) myvtable offset sp =
            let
              val rpe = "_rpe" ^ newName ()
              val (pmips, pvtable) = 
                compilePat pat rpe myvtable fail (offset - 4)
              val (imips, ivtable) = 
                iter pats pvtable (offset-4) sp
            in
              ([Mips.LW(rpe, sp, makeConst (offset-4))] @ pmips @ imips, ivtable) 
            end
        val x = [Mips.LW(ta, v, "0")]
        val (xmips, xvtable) = iter plist vtable 0 ta
      in
        (x @ xmips, xvtable)
      end
      
  (* compile expression *)
  fun compileExp e vtable ttable place =
  let
    val mtrue   = Mips.ORI (place, "0", makeConst ~1)
    val mfalse  = Mips.ORI (place, "0", makeConst 0)
  in
    case e of
      Cat.Num (n, _) =>
        if n < 32768 then [Mips.LI (place, makeConst n)]
	      else
	        [
           Mips.LUI (place, makeConst (n div 65536)),
	         Mips.ORI (place, place, makeConst (n mod 65536))
          ]
    | Cat.True  _ => [mtrue]
    | Cat.False _ => [mfalse]
    | Cat.Null _ => [mfalse]
    | Cat.MkTuple (exps, name, _) =>
        let
          fun iter [] = []
            | iter (e::es) = 
              let
                val re = name ^ "_e" ^ newName ()
                val ce = compileExp e vtable ttable re
              in
                ce @ [Mips.SW(re, SP,"0"), Mips.ADDI(SP, SP, "-4")] @ iter es
              end
        in
          [Mips.MOVE(place,SP), Mips.SW(SP, SP, "0"), Mips.ADDI (SP, SP, "-4")]
          @ iter exps
        end
    | Cat.Not (e, _)  => 
        let
          val re    = "_re_"      ^ newName ()
          val lend  = "_lend_"    ^ newName ()
          val lelse = "_lelse_"   ^ newName ()
          val ce    = compileExp e vtable ttable re
        in
          ce @ 
          [
           Mips.BEQ (re, "0", lelse),
           mfalse,
           Mips.J lend,
           Mips.LABEL lelse,
           mtrue,
           Mips.LABEL lend
          ]
        end
    | Cat.Less (e1, e2, _) =>
        let
          val rs    = "_rs_"      ^ newName ()
          val rt    = "_rt_"      ^ newName ()
          val rd    = "_rd_"      ^ newName ()
          val lend  = "_lend_"    ^ newName ()
          val cs   = compileExp e1 vtable ttable rs
          val ct   = compileExp e2 vtable ttable rt
        in
          cs @ ct @
          [
           Mips.SLT (rd, rs, rt),
           Mips.BEQ (rd, "0", lend),
           mtrue,
           Mips.LABEL lend
          ]
        end
    | Cat.Equal (e1, e2, _) =>
        let
          val rs    = "_rs"      ^ newName ()
          val rt    = "_rt"      ^ newName ()
          val rd    = "_rd"      ^ newName ()
          val lelse = "_lelse"   ^ newName ()
          val lend  = "_lend"    ^ newName ()
          val cs   = compileExp e1 vtable ttable rs
          val ct   = compileExp e2 vtable ttable rt
        in
          cs @ ct @
          [
           Mips.XOR (place, rs, rt),
           Mips.BEQ (place, "0", lelse),
           mfalse,
           Mips.J lend,
           Mips.LABEL lelse,
           mtrue,
           Mips.LABEL lend
          ]
        end
    | Cat.And (e1, e2, _) =>
        let
          val c1 = compileExp e1 vtable ttable place
          val c2 = compileExp e2 vtable ttable place
          val lend  = "_lend"    ^ newName ()
        in
          c1 @ 
          [Mips.BEQ (place, "0", lend)] @ 
          c2 @
          [
           Mips.BEQ (place, "0", lend), 
           Mips.LABEL lend
          ]
        end
    | Cat.Or (e1, e2, _) =>
        let
          val c1 = compileExp e1 vtable ttable place
          val c2 = compileExp e2 vtable ttable place
          val lend  = "_lend"    ^ newName ()
        in
          c1 @ 
          [Mips.BNE (place, "0", lend)] @ 
          c2 @ 
          [
           Mips.BEQ (place, "0", lend),
           Mips.LABEL lend
          ]
        end
    | Cat.If (e1, e2, e3, _) => 
        let
          val r1 = "_r1" ^ newName ()
          val c1 = compileExp e1 vtable ttable r1
          val c2 = compileExp e2 vtable ttable place
          val c3 = compileExp e3 vtable ttable place
          val lelse  = "_lelse"    ^ newName ()
          val lend  = "_lend"    ^ newName ()
        in
          c1 @ [Mips.BEQ (r1, "0", lelse)] @ c2 @
          [Mips.J lend, Mips.LABEL lelse] @ c3 @
          [Mips.LABEL lend]
        end
    | Cat.Case (e, m, p) =>
        let
          val lf = "_case" ^ newName ()
          val cf = compileFun vtable ttable (lf, Cat.Int (0,0), Cat.Int (0,0), m, p)
        in
          cf @ (compileExp (Cat.Apply (lf, e, p)) vtable ttable place)
        end

    | Cat.Let ([], e, _) => (compileExp e vtable ttable place)
    | Cat.Let (((dp, de, dpos) :: decs), exp, (line, column)) =>
        let
          val rde = "_apply" ^ newName ()
          val exit = "_case_exit" ^ newName ()
          val fail = "_cas_fail"^ newName()
          val cde = compileExp de vtable ttable rde
          val errorcode     (* if match fails *)
	          = [Mips.LABEL fail,
	             Mips.LI ("5", makeConst line),
	             Mips.J "_Error_"]
          val body = 
            compileMatch [(dp, Cat.Let(decs, exp, (line, column)))] "" rde place 
            exit fail vtable ttable
        in
          cde @ body @ errorcode @ [Mips.LABEL exit]
        end

    | Cat.Var (x, pos) => [Mips.MOVE (place, lookup x vtable pos)]
    | Cat.Plus (e1, e2, _) =>
        let
	        val re1 = "_plus1_" ^ newName ()
	        val re2 = "_plus2_" ^ newName ()
          val ce1 = compileExp e1 vtable ttable re1
          val ce2 = compileExp e2 vtable ttable re2
	      in
	        ce1 @ ce2 @ [Mips.ADD (place, re1, re2)]
	      end
    | Cat.Minus (e1, e2, _) =>
        let
	        val re1 = "_minus1_" ^ newName ()
	        val re2 = "_minus2_" ^ newName ()
          val ce1 = compileExp e1 vtable ttable re1
          val ce2 = compileExp e2 vtable ttable re2
	      in
	        ce1 @ ce2 @ [Mips.SUB (place, re1, re2)]
	      end
    | Cat.Apply (f, e, _) =>
	      let
	        val re = "_apply_"^newName()
	        val ce = compileExp e vtable ttable re
	      in
	        ce @
          [
           Mips.MOVE ("2", re), 
           Mips.JAL (f, ["2"]), 
           Mips.MOVE (place, "2")
          ]
	      end
    | Cat.Read pos =>
        [
         Mips.LI ("2","5"), (* read_int syscall *)
         Mips.SYSCALL,
         Mips.MOVE (place,"2")
        ]
    | Cat.Write (e,pos) => 
        (compileExp e vtable ttable place) @ 
        [
         Mips.MOVE ("4",place),
	       Mips.LI ("2","1"),  (* write_int syscall *)
	       Mips.SYSCALL,
	       Mips.LA ("4","_cr_"),
	       Mips.LI ("2","4"),  (* write_string syscall *)
	       Mips.SYSCALL
        ]
  end


  and compileMatch [] atype arg res endLabel failLabel vtable ttable = [Mips.J failLabel]
    | compileMatch ((p,e)::m) atype arg res endLabel failLabel vtable ttable =
        let
	        val lnext = "_lnext_" ^ newName ()
	        val (cp, vtable1) = compilePat p arg vtable lnext 0
	        val ce = compileExp e vtable1 ttable res
	        val cm = compileMatch m atype arg res endLabel failLabel vtable ttable
	      in
	        cp @ ce @ [Mips.J endLabel, Mips.LABEL lnext] @ cm
	      end

  (* code for saving and restoring callee-saves registers *)
  and stackSave currentReg maxReg savecode restorecode offset =
    if currentReg > maxReg
    then (savecode, restorecode, offset)  (* done *)
    else stackSave (currentReg+1)
                   maxReg
                   (Mips.SW (makeConst currentReg,
                                 SP,
                                 makeConst offset)
                    :: savecode) (* save register *)
                   (Mips.LW (makeConst currentReg,
                                 SP,
                                 makeConst offset)
                    :: restorecode) (* restore register *)
                   (offset-4) (* adjust offset *)


  (* compile function declaration *)
  and compileFun vtable ttable (fname, argty, resty, m, (line,col)) =
        let
	        val atmp = fname ^"_arg_"^ newName()
          val rtmp = fname ^"_res_"^ newName()
          val exit = fname ^"_return_"^ newName()
          val fail = fname ^"_fail_"^ newName()
          val tyname = 
            (case (argty) of
               (Cat.TyVar(name,_)) => name
             | _ => "")
	        val parcode       (* move R2 to argument *)
            = [Mips.MOVE (atmp, "2")]
          val returncode    (* move return value to R2 *)
            = [Mips.LABEL exit, Mips.MOVE ("2",rtmp)]
          val errorcode     (* if match fails *)
	          = [Mips.LABEL fail,
	             Mips.LI ("5",makeConst line),
	             Mips.J "_Error_"]
          val body = compileMatch m tyname atmp rtmp exit fail vtable ttable
          val (body1, _, maxr)  (* call register allocator *)
            = RegAlloc.registerAlloc
                (parcode @ body @ returncode) ["2"] 2 maxCaller maxReg
          val (savecode, restorecode, offset) = (* save/restore callee-saves *)
                stackSave (maxCaller+1) maxr [] [] (~8)
        in
            [Mips.COMMENT "",
             Mips.LABEL fname,  (* function label *)
             Mips.SW (RA, SP, "-4")] (* save return address *)
          @ savecode  (* save callee-saves registers *)
          @ [Mips.ADDI (SP,SP,makeConst offset)] (* move SP down *)
          @ body1  (* code for function body *)
          @ [Mips.ADDI (SP,SP,makeConst (~offset))] (* move SP up *)
          @ restorecode  (* restore callee-saves registers *)
          @ [Mips.LW (RA, SP, "-4"), (* restore return addr *)
             Mips.JR (RA, [])] (* return *)
	  @ errorcode
        end

 (*  fun compileFun vtable (fname, argty, resty, m, (line,col)) = *)

  (* compile program *)
  fun compile (tys, funs, e) =
    let
      val funsCode = List.concat (List.map (compileFun [] tys) funs)
      val mainCode = compileExp e [] tys "dead" @ [Mips.J "_stop_"]
      val (code1, _, _)
             = RegAlloc.registerAlloc mainCode [] 2 maxCaller maxReg
    in
      [Mips.TEXT "0x00400000",
       Mips.GLOBL "main",
       Mips.LABEL "main",
       Mips.LA (HP, "_heap_")]    (* initialise heap pointer *)
      @ code1                    (* run program *)
      @ funsCode		  (* code for functions *)
      @ [Mips.LABEL "_stop_",
         Mips.LI ("2","10"),      (* syscall control = 10 *)
         Mips.SYSCALL,            (* exit *)
         Mips.LABEL "_Error_",    (* code for reporting match errors *)
	 Mips.LA ("4","_ErrorString_"),
	 Mips.LI ("2","4"), Mips.SYSCALL, (* print string *)
	 Mips.MOVE ("4","5"),
	 Mips.LI ("2","1"), Mips.SYSCALL, (* print line number *)
	 Mips.LA ("4","_cr_"),
	 Mips.LI ("2","4"), Mips.SYSCALL, (* print CR *)
	 Mips.J "_stop_",
	 Mips.DATA "",
	 Mips.LABEL "_cr_",       (* carriage return string *)
	 Mips.ASCIIZ "\n",
	 Mips.LABEL "_ErrorString_",
	 Mips.ASCIIZ "Match failed near line ",
	 Mips.ALIGN "2",
	 Mips.LABEL "_heap_",
	 Mips.SPACE "100000"]
    end

end
