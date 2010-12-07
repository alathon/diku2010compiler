local
type t__1__ = (int*int)
type t__2__ = (int*int)
type t__3__ = (int*int)
type t__4__ = (int*int)
type t__5__ = (int*int)
type t__6__ = (int*int)
type t__7__ = (int*int)
type t__8__ = (int*int)
type t__9__ = (int*int)
type t__10__ = (int*int)
type t__11__ = (int*int)
type t__12__ = (int*int)
type t__13__ = (int*int)
type t__14__ = string*(int*int)
type t__15__ = (int*int)
type t__16__ = (int*int)
type t__17__ = (int*int)
type t__18__ = (int*int)
type t__19__ = (int*int)
type t__20__ = (int*int)
type t__21__ = (int*int)
type t__22__ = int*(int*int)
type t__23__ = (int*int)
type t__24__ = (int*int)
type t__25__ = (int*int)
type t__26__ = (int*int)
type t__27__ = (int*int)
type t__28__ = (int*int)
type t__29__ = (int*int)
in
datatype token =
    AND of t__1__
  | ARROW of t__2__
  | BAR of t__3__
  | BOOL of t__4__
  | COLON of t__5__
  | COMMA of t__6__
  | ELSE of t__7__
  | END of t__8__
  | EOF of t__9__
  | EQUALS of t__10__
  | FALSE of t__11__
  | FUN of t__12__
  | GT of t__13__
  | ID of t__14__
  | IN of t__15__
  | INT of t__16__
  | LPAR of t__17__
  | LT of t__18__
  | MATCHARROW of t__19__
  | MINUS of t__20__
  | NOT of t__21__
  | NUM of t__22__
  | OR of t__23__
  | PLUS of t__24__
  | READ of t__25__
  | RPAR of t__26__
  | SEMICOLON of t__27__
  | TRUE of t__28__
  | WRITE of t__29__
end;

open Obj Parsing;
prim_val vector_ : int -> 'a -> 'a Vector.vector = 2 "make_vect";
prim_val update_ : 'a Vector.vector -> int -> 'a -> unit = 3 "set_vect_item";

val yytransl = #[
  257 (* AND *),
  258 (* ARROW *),
  259 (* BAR *),
  260 (* BOOL *),
  261 (* COLON *),
  262 (* COMMA *),
  263 (* ELSE *),
  264 (* END *),
  265 (* EOF *),
  266 (* EQUALS *),
  267 (* FALSE *),
  268 (* FUN *),
  269 (* GT *),
  270 (* ID *),
  271 (* IN *),
  272 (* INT *),
  273 (* LPAR *),
  274 (* LT *),
  275 (* MATCHARROW *),
  276 (* MINUS *),
  277 (* NOT *),
  278 (* NUM *),
  279 (* OR *),
  280 (* PLUS *),
  281 (* READ *),
  282 (* RPAR *),
  283 (* SEMICOLON *),
  284 (* TRUE *),
  285 (* WRITE *),
    0];

val yylhs = "\255\255\
\\001\000\008\000\008\000\002\000\002\000\006\000\006\000\006\000\
\\006\000\007\000\007\000\005\000\005\000\003\000\003\000\003\000\
\\003\000\003\000\003\000\003\000\003\000\003\000\003\000\004\000\
\\004\000\000\000";

val yylen = "\002\000\
\\003\000\009\000\000\000\001\000\001\000\001\000\001\000\001\000\
\\001\000\001\000\003\000\003\000\003\000\001\000\001\000\001\000\
\\001\000\003\000\003\000\002\000\001\000\002\000\003\000\001\000\
\\003\000\002\000";

val yydefred = "\000\000\
\\000\000\000\000\000\000\026\000\000\000\000\000\016\000\000\000\
\\000\000\014\000\021\000\015\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\001\000\000\000\000\000\005\000\004\000\000\000\
\\023\000\000\000\000\000\000\000\000\000\008\000\007\000\006\000\
\\009\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\
\\000\000";

val yydgoto = "\002\000\
\\004\000\024\000\014\000\000\000\034\000\035\000\000\000\005\000";

val yysindex = "\003\000\
\\006\255\000\000\014\255\000\000\248\254\035\255\000\000\248\254\
\\248\254\000\000\000\000\000\000\248\254\002\255\020\255\000\000\
\\053\255\000\000\000\000\248\254\248\254\000\000\000\000\041\255\
\\000\000\000\000\000\000\020\255\037\255\000\000\000\000\000\000\
\\000\000\039\255\022\255\037\255\006\255\248\254\051\255\000\000\
\\046\255";

val yyrindex = "\000\000\
\\047\255\000\000\000\000\000\000\000\000\000\000\000\000\255\254\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\007\255\
\\000\000\026\255\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\029\255\036\255\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\047\255\000\000\049\255\000\000\
\\060\255";

val yygindex = "\000\000\
\\000\000\039\000\248\255\000\000\035\000\000\000\000\000\037\000";

val YYTABLESIZE = 79;
val yytable = "\016\000\
\\017\000\017\000\007\000\001\000\018\000\008\000\017\000\017\000\
\\009\000\020\000\019\000\026\000\027\000\010\000\020\000\020\000\
\\011\000\003\000\017\000\012\000\013\000\020\000\017\000\022\000\
\\017\000\021\000\020\000\006\000\022\000\041\000\020\000\019\000\
\\020\000\022\000\022\000\023\000\019\000\019\000\018\000\015\000\
\\038\000\036\000\028\000\018\000\018\000\022\000\037\000\030\000\
\\019\000\022\000\031\000\022\000\019\000\036\000\019\000\018\000\
\\013\000\003\000\032\000\018\000\003\000\018\000\012\000\003\000\
\\033\000\020\000\029\000\012\000\003\000\021\000\039\000\003\000\
\\020\000\040\000\003\000\003\000\021\000\000\000\025\000";

val yycheck = "\008\000\
\\009\000\003\001\011\001\001\000\013\000\014\001\008\001\009\001\
\\017\001\003\001\009\001\020\000\021\000\022\001\008\001\009\001\
\\025\001\012\001\020\001\028\001\029\001\020\001\024\001\004\001\
\\026\001\024\001\020\001\014\001\003\001\038\000\024\001\003\001\
\\026\001\008\001\009\001\016\001\008\001\009\001\003\001\005\001\
\\019\001\003\001\002\001\008\001\009\001\020\001\008\001\011\001\
\\020\001\024\001\014\001\026\001\024\001\003\001\026\001\020\001\
\\008\001\011\001\022\001\024\001\014\001\026\001\003\001\017\001\
\\028\001\020\001\028\000\008\001\022\001\024\001\036\000\025\001\
\\020\001\037\000\028\001\029\001\024\001\255\255\026\001";

val yyact = vector_ 27 (fn () => ((raise Fail "parser") : obj));
(* Rule 1, file Parser.grm, line 38 *)
val _ = update_ yyact 1
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.FunDec list
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( ([],(d__1__),(d__2__)) ) end : Cat.Prog))
;
(* Rule 2, file Parser.grm, line 42 *)
val _ = update_ yyact 2
(fn () => repr(let
val d__1__ = peekVal 8 : (int*int)
val d__2__ = peekVal 7 : string*(int*int)
val d__3__ = peekVal 6 : (int*int)
val d__4__ = peekVal 5 : Cat.Type
val d__5__ = peekVal 4 : (int*int)
val d__6__ = peekVal 3 : Cat.Type
val d__7__ = peekVal 2 : Cat.Match
val d__8__ = peekVal 1 : (int*int)
val d__9__ = peekVal 0 : Cat.FunDec list
in
( (#1 (d__2__), (d__4__), (d__6__), (d__7__), (d__1__)) :: (d__9__) ) end : Cat.FunDec list))
;
(* Rule 3, file Parser.grm, line 43 *)
val _ = update_ yyact 3
(fn () => repr(let
in
( [] ) end : Cat.FunDec list))
;
(* Rule 4, file Parser.grm, line 46 *)
val _ = update_ yyact 4
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Int (d__1__) ) end : Cat.Type))
;
(* Rule 5, file Parser.grm, line 47 *)
val _ = update_ yyact 5
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Bool (d__1__) ) end : Cat.Type))
;
(* Rule 6, file Parser.grm, line 51 *)
val _ = update_ yyact 6
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.NumP (d__1__) ) end : Cat.Pat))
;
(* Rule 7, file Parser.grm, line 52 *)
val _ = update_ yyact 7
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.VarP (d__1__) ) end : Cat.Pat))
;
(* Rule 8, file Parser.grm, line 53 *)
val _ = update_ yyact 8
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.FalseP (d__1__) ) end : Cat.Pat))
;
(* Rule 9, file Parser.grm, line 54 *)
val _ = update_ yyact 9
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.TrueP (d__1__) ) end : Cat.Pat))
;
(* Rule 10, file Parser.grm, line 57 *)
val _ = update_ yyact 10
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Pat
in
( [(d__1__)] ) end : Cat.Pat list))
;
(* Rule 11, file Parser.grm, line 58 *)
val _ = update_ yyact 11
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Pat list
in
( (d__1__) :: (d__3__) ) end : Cat.Pat list))
;
(* Rule 12, file Parser.grm, line 62 *)
val _ = update_ yyact 12
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( [((d__1__),(d__3__))] ) end : Cat.Match))
;
(* Rule 13, file Parser.grm, line 64 *)
val _ = update_ yyact 13
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Match
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Match
in
( (d__1__) @ (d__3__) ) end : Cat.Match))
;
(* Rule 14, file Parser.grm, line 67 *)
val _ = update_ yyact 14
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.Num (d__1__) ) end : Cat.Exp))
;
(* Rule 15, file Parser.grm, line 68 *)
val _ = update_ yyact 15
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.True (d__1__) ) end : Cat.Exp))
;
(* Rule 16, file Parser.grm, line 69 *)
val _ = update_ yyact 16
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.False (d__1__) ) end : Cat.Exp))
;
(* Rule 17, file Parser.grm, line 70 *)
val _ = update_ yyact 17
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.Var (d__1__) ) end : Cat.Exp))
;
(* Rule 18, file Parser.grm, line 71 *)
val _ = update_ yyact 18
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Plus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 19, file Parser.grm, line 72 *)
val _ = update_ yyact 19
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Minus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 20, file Parser.grm, line 74 *)
val _ = update_ yyact 20
(fn () => repr(let
val d__1__ = peekVal 1 : string*(int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Apply (#1 (d__1__), (d__2__), #2 (d__1__)) ) end : Cat.Exp))
;
(* Rule 21, file Parser.grm, line 75 *)
val _ = update_ yyact 21
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Read (d__1__) ) end : Cat.Exp))
;
(* Rule 22, file Parser.grm, line 76 *)
val _ = update_ yyact 22
(fn () => repr(let
val d__1__ = peekVal 1 : (int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Write ((d__2__), (d__1__)) ) end : Cat.Exp))
;
(* Rule 23, file Parser.grm, line 77 *)
val _ = update_ yyact 23
(fn () => repr(let
val d__1__ = peekVal 2 : (int*int)
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( (d__2__) ) end : Cat.Exp))
;
(* Rule 24, file Parser.grm, line 81 *)
val _ = update_ yyact 24
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Exp
in
( [(d__1__)] ) end : Cat.Exp list))
;
(* Rule 25, file Parser.grm, line 82 *)
val _ = update_ yyact 25
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp list
in
( (d__1__) :: (d__3__) ) end : Cat.Exp list))
;
(* Entry Prog *)
val _ = update_ yyact 26 (fn () => raise yyexit (peekVal 0));
val yytables : parseTables =
  ( yyact,
    yytransl,
    yylhs,
    yylen,
    yydefred,
    yydgoto,
    yysindex,
    yyrindex,
    yygindex,
    YYTABLESIZE,
    yytable,
    yycheck );
fun Prog lexer lexbuf = yyparse yytables 1 lexer lexbuf;
