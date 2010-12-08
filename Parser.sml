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
type t__14__ = (int*int)
type t__15__ = string*(int*int)
type t__16__ = (int*int)
type t__17__ = (int*int)
type t__18__ = (int*int)
type t__19__ = (int*int)
type t__20__ = (int*int)
type t__21__ = (int*int)
type t__22__ = (int*int)
type t__23__ = (int*int)
type t__24__ = (int*int)
type t__25__ = int*(int*int)
type t__26__ = (int*int)
type t__27__ = (int*int)
type t__28__ = (int*int)
type t__29__ = (int*int)
type t__30__ = (int*int)
type t__31__ = (int*int)
type t__32__ = (int*int)
type t__33__ = string*(int*int)
type t__34__ = (int*int)
in
datatype token =
    AND of t__1__
  | ARROW of t__2__
  | AT of t__3__
  | BAR of t__4__
  | BOOL of t__5__
  | CASE of t__6__
  | COLON of t__7__
  | COMMA of t__8__
  | ELSE of t__9__
  | END of t__10__
  | EOF of t__11__
  | EQUALS of t__12__
  | FALSE of t__13__
  | FUN of t__14__
  | ID of t__15__
  | IN of t__16__
  | INT of t__17__
  | LET of t__18__
  | LPAR of t__19__
  | LT of t__20__
  | MATCHARROW of t__21__
  | MINUS of t__22__
  | NOT of t__23__
  | NULL of t__24__
  | NUM of t__25__
  | OF of t__26__
  | OR of t__27__
  | PLUS of t__28__
  | READ of t__29__
  | RPAR of t__30__
  | SEMICOLON of t__31__
  | TRUE of t__32__
  | TYPE of t__33__
  | WRITE of t__34__
end;

open Obj Parsing;
prim_val vector_ : int -> 'a -> 'a Vector.vector = 2 "make_vect";
prim_val update_ : 'a Vector.vector -> int -> 'a -> unit = 3 "set_vect_item";

val yytransl = #[
  257 (* AND *),
  258 (* ARROW *),
  259 (* AT *),
  260 (* BAR *),
  261 (* BOOL *),
  262 (* CASE *),
  263 (* COLON *),
  264 (* COMMA *),
  265 (* ELSE *),
  266 (* END *),
  267 (* EOF *),
  268 (* EQUALS *),
  269 (* FALSE *),
  270 (* FUN *),
  271 (* ID *),
  272 (* IN *),
  273 (* INT *),
  274 (* LET *),
  275 (* LPAR *),
  276 (* LT *),
  277 (* MATCHARROW *),
  278 (* MINUS *),
  279 (* NOT *),
  280 (* NULL *),
  281 (* NUM *),
  282 (* OF *),
  283 (* OR *),
  284 (* PLUS *),
  285 (* READ *),
  286 (* RPAR *),
  287 (* SEMICOLON *),
  288 (* TRUE *),
  289 (* TYPE *),
  290 (* WRITE *),
    0];

val yylhs = "\255\255\
\\001\000\009\000\009\000\010\000\010\000\002\000\002\000\002\000\
\\003\000\003\000\007\000\007\000\007\000\007\000\007\000\008\000\
\\008\000\006\000\006\000\004\000\004\000\004\000\004\000\004\000\
\\004\000\004\000\004\000\004\000\004\000\004\000\004\000\004\000\
\\004\000\004\000\004\000\005\000\005\000\000\000";

val yylen = "\002\000\
\\004\000\007\000\000\000\009\000\000\000\001\000\001\000\001\000\
\\001\000\003\000\001\000\001\000\001\000\001\000\001\000\001\000\
\\003\000\003\000\003\000\001\000\001\000\001\000\003\000\001\000\
\\003\000\003\000\003\000\003\000\002\000\003\000\003\000\002\000\
\\001\000\002\000\003\000\001\000\003\000\002\000";

val yydefred = "\000\000\
\\000\000\000\000\000\000\038\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\022\000\000\000\000\000\000\000\000\000\020\000\
\\033\000\021\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\\000\000\000\000\007\000\008\000\006\000\000\000\000\000\000\000\
\\035\000\023\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\010\000\002\000\000\000\013\000\015\000\
\\014\000\011\000\012\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\004\000\000\000";

val yydgoto = "\002\000\
\\004\000\038\000\039\000\020\000\000\000\060\000\061\000\000\000\
\\005\000\008\000";

val yysindex = "\005\000\
\\232\254\000\000\253\254\000\000\255\254\003\255\011\255\187\255\
\\009\255\022\255\000\000\187\255\187\255\187\255\037\255\000\000\
\\000\000\000\000\187\255\091\255\034\255\034\255\000\000\071\255\
\\000\000\032\255\000\000\187\255\000\000\187\255\187\255\187\255\
\\187\255\187\255\000\000\000\000\000\000\052\255\015\255\059\255\
\\000\000\000\000\062\255\007\255\007\255\030\255\007\255\030\255\
\\034\255\232\254\034\255\000\000\000\000\172\255\000\000\000\000\
\\000\000\000\000\000\000\000\255\046\255\172\255\255\254\187\255\
\\067\255\000\000\088\255";

val yyrindex = "\000\000\
\\169\255\000\000\000\000\000\000\205\255\000\000\000\000\000\000\
\\000\000\000\000\000\000\013\255\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\026\255\000\000\
\\054\255\000\000\058\255\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\043\255\000\000\000\000\
\\000\000\000\000\110\255\135\255\138\255\148\255\113\255\151\255\
\\000\000\169\255\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\205\255\000\000\
\\065\255\000\000\001\255";

val yygindex = "\000\000\
\\000\000\237\255\028\000\244\255\000\000\017\000\000\000\000\000\
\\037\000\027\000";

val YYTABLESIZE = 239;
val yytable = "\023\000\
\\024\000\025\000\040\000\062\000\018\000\001\000\027\000\028\000\
\\003\000\063\000\018\000\006\000\007\000\024\000\009\000\043\000\
\\024\000\044\000\045\000\046\000\047\000\048\000\024\000\024\000\
\\024\000\010\000\032\000\021\000\022\000\032\000\028\000\054\000\
\\024\000\033\000\024\000\032\000\032\000\032\000\035\000\024\000\
\\024\000\030\000\024\000\026\000\050\000\032\000\042\000\032\000\
\\036\000\031\000\037\000\067\000\032\000\032\000\029\000\032\000\
\\033\000\029\000\034\000\049\000\051\000\034\000\028\000\029\000\
\\029\000\029\000\064\000\034\000\034\000\034\000\062\000\028\000\
\\009\000\029\000\019\000\029\000\052\000\034\000\065\000\034\000\
\\029\000\029\000\030\000\029\000\034\000\034\000\053\000\034\000\
\\028\000\066\000\031\000\028\000\032\000\000\000\000\000\000\000\
\\000\000\033\000\034\000\030\000\041\000\029\000\030\000\000\000\
\\000\000\000\000\000\000\031\000\000\000\032\000\031\000\000\000\
\\032\000\030\000\033\000\034\000\031\000\033\000\034\000\030\000\
\\030\000\030\000\031\000\031\000\031\000\000\000\000\000\000\000\
\\000\000\030\000\000\000\030\000\031\000\000\000\031\000\000\000\
\\030\000\030\000\027\000\030\000\031\000\028\000\031\000\000\000\
\\027\000\027\000\000\000\028\000\028\000\000\000\000\000\026\000\
\\000\000\000\000\025\000\000\000\027\000\026\000\026\000\028\000\
\\025\000\025\000\027\000\000\000\027\000\028\000\000\000\028\000\
\\000\000\026\000\000\000\000\000\025\000\000\000\000\000\026\000\
\\000\000\026\000\025\000\000\000\025\000\003\000\003\000\003\000\
\\055\000\000\000\056\000\003\000\000\000\000\000\000\000\003\000\
\\003\000\003\000\000\000\057\000\058\000\003\000\000\000\011\000\
\\003\000\012\000\003\000\059\000\000\000\013\000\000\000\000\000\
\\000\000\014\000\015\000\016\000\000\000\000\000\000\000\017\000\
\\000\000\005\000\018\000\005\000\019\000\000\000\000\000\005\000\
\\000\000\000\000\000\000\005\000\005\000\005\000\000\000\000\000\
\\000\000\005\000\000\000\000\000\005\000\000\000\005\000";

val yycheck = "\012\000\
\\013\000\014\000\022\000\004\001\004\001\001\000\019\000\001\001\
\\033\001\010\001\010\001\015\001\014\001\001\001\012\001\028\000\
\\004\001\030\000\031\000\032\000\033\000\034\000\010\001\011\001\
\\012\001\015\001\001\001\019\001\007\001\004\001\001\001\051\000\
\\020\001\027\001\022\001\010\001\011\001\012\001\005\001\027\001\
\\028\001\012\001\030\001\007\001\030\001\020\001\015\001\022\001\
\\015\001\020\001\017\001\064\000\027\001\028\001\001\001\030\001\
\\027\001\004\001\001\001\008\001\002\001\004\001\001\001\010\001\
\\011\001\012\001\021\001\010\001\011\001\012\001\004\001\001\001\
\\030\001\020\001\010\001\022\001\049\000\020\001\062\000\022\001\
\\027\001\028\001\012\001\030\001\027\001\028\001\050\000\030\001\
\\001\001\063\000\020\001\001\001\022\001\255\255\255\255\255\255\
\\255\255\027\001\028\001\012\001\030\001\011\001\012\001\255\255\
\\255\255\255\255\255\255\020\001\255\255\022\001\020\001\255\255\
\\022\001\004\001\027\001\028\001\004\001\027\001\028\001\010\001\
\\011\001\012\001\010\001\011\001\012\001\255\255\255\255\255\255\
\\255\255\020\001\255\255\022\001\020\001\255\255\022\001\255\255\
\\027\001\028\001\004\001\030\001\028\001\004\001\030\001\255\255\
\\010\001\011\001\255\255\010\001\011\001\255\255\255\255\004\001\
\\255\255\255\255\004\001\255\255\022\001\010\001\011\001\022\001\
\\010\001\011\001\028\001\255\255\030\001\028\001\255\255\030\001\
\\255\255\022\001\255\255\255\255\022\001\255\255\255\255\028\001\
\\255\255\030\001\028\001\255\255\030\001\013\001\014\001\015\001\
\\013\001\255\255\015\001\019\001\255\255\255\255\255\255\023\001\
\\024\001\025\001\255\255\024\001\025\001\029\001\255\255\013\001\
\\032\001\015\001\034\001\032\001\255\255\019\001\255\255\255\255\
\\255\255\023\001\024\001\025\001\255\255\255\255\255\255\029\001\
\\255\255\013\001\032\001\015\001\034\001\255\255\255\255\019\001\
\\255\255\255\255\255\255\023\001\024\001\025\001\255\255\255\255\
\\255\255\029\001\255\255\255\255\032\001\255\255\034\001";

val yyact = vector_ 39 (fn () => ((raise Fail "parser") : obj));
(* Rule 1, file Parser.grm, line 44 *)
val _ = update_ yyact 1
(fn () => repr(let
val d__1__ = peekVal 3 : Cat.TyDec list
val d__2__ = peekVal 2 : Cat.FunDec list
val d__3__ = peekVal 1 : Cat.Exp
val d__4__ = peekVal 0 : (int*int)
in
( ((d__1__),(d__2__),(d__3__)) ) end : Cat.Prog))
;
(* Rule 2, file Parser.grm, line 48 *)
val _ = update_ yyact 2
(fn () => repr(let
val d__1__ = peekVal 6 : string*(int*int)
val d__2__ = peekVal 5 : string*(int*int)
val d__3__ = peekVal 4 : (int*int)
val d__4__ = peekVal 3 : (int*int)
val d__5__ = peekVal 2 : Cat.Type list
val d__6__ = peekVal 1 : (int*int)
val d__7__ = peekVal 0 : Cat.TyDec list
in
( (#1 (d__2__), (d__5__), #2 (d__1__)) :: (d__7__) ) end : Cat.TyDec list))
;
(* Rule 3, file Parser.grm, line 49 *)
val _ = update_ yyact 3
(fn () => repr(let
in
( [] ) end : Cat.TyDec list))
;
(* Rule 4, file Parser.grm, line 53 *)
val _ = update_ yyact 4
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
(* Rule 5, file Parser.grm, line 54 *)
val _ = update_ yyact 5
(fn () => repr(let
in
( [] ) end : Cat.FunDec list))
;
(* Rule 6, file Parser.grm, line 58 *)
val _ = update_ yyact 6
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Int (d__1__) ) end : Cat.Type))
;
(* Rule 7, file Parser.grm, line 59 *)
val _ = update_ yyact 7
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Bool (d__1__) ) end : Cat.Type))
;
(* Rule 8, file Parser.grm, line 60 *)
val _ = update_ yyact 8
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.TyVar (d__1__) ) end : Cat.Type))
;
(* Rule 9, file Parser.grm, line 63 *)
val _ = update_ yyact 9
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Type
in
( [(d__1__)] ) end : Cat.Type list))
;
(* Rule 10, file Parser.grm, line 64 *)
val _ = update_ yyact 10
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Type
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Type list
in
( (d__1__) :: (d__3__) ) end : Cat.Type list))
;
(* Rule 11, file Parser.grm, line 67 *)
val _ = update_ yyact 11
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.NumP (d__1__) ) end : Cat.Pat))
;
(* Rule 12, file Parser.grm, line 68 *)
val _ = update_ yyact 12
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.TrueP (d__1__) ) end : Cat.Pat))
;
(* Rule 13, file Parser.grm, line 69 *)
val _ = update_ yyact 13
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.FalseP (d__1__) ) end : Cat.Pat))
;
(* Rule 14, file Parser.grm, line 70 *)
val _ = update_ yyact 14
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.NullP (d__1__) ) end : Cat.Pat))
;
(* Rule 15, file Parser.grm, line 71 *)
val _ = update_ yyact 15
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.VarP (d__1__) ) end : Cat.Pat))
;
(* Rule 16, file Parser.grm, line 75 *)
val _ = update_ yyact 16
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Pat
in
( [(d__1__)] ) end : Cat.Pat list))
;
(* Rule 17, file Parser.grm, line 76 *)
val _ = update_ yyact 17
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Pat list
in
( (d__1__) :: (d__3__) ) end : Cat.Pat list))
;
(* Rule 18, file Parser.grm, line 80 *)
val _ = update_ yyact 18
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( [((d__1__),(d__3__))] ) end : Cat.Match))
;
(* Rule 19, file Parser.grm, line 82 *)
val _ = update_ yyact 19
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Match
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Match
in
( (d__1__) @ (d__3__) ) end : Cat.Match))
;
(* Rule 20, file Parser.grm, line 85 *)
val _ = update_ yyact 20
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.Num (d__1__) ) end : Cat.Exp))
;
(* Rule 21, file Parser.grm, line 86 *)
val _ = update_ yyact 21
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.True (d__1__) ) end : Cat.Exp))
;
(* Rule 22, file Parser.grm, line 87 *)
val _ = update_ yyact 22
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.False (d__1__) ) end : Cat.Exp))
;
(* Rule 23, file Parser.grm, line 88 *)
val _ = update_ yyact 23
(fn () => repr(let
val d__1__ = peekVal 2 : (int*int)
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : string*(int*int)
in
( Cat.Null ((#1 (d__3__)) ,(d__1__)) ) end : Cat.Exp))
;
(* Rule 24, file Parser.grm, line 89 *)
val _ = update_ yyact 24
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.Var (d__1__) ) end : Cat.Exp))
;
(* Rule 25, file Parser.grm, line 90 *)
val _ = update_ yyact 25
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Plus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 26, file Parser.grm, line 91 *)
val _ = update_ yyact 26
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Minus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 27, file Parser.grm, line 92 *)
val _ = update_ yyact 27
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Equal ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 28, file Parser.grm, line 93 *)
val _ = update_ yyact 28
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Less ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 29, file Parser.grm, line 94 *)
val _ = update_ yyact 29
(fn () => repr(let
val d__1__ = peekVal 1 : (int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Not ((d__2__), (d__1__)) ) end : Cat.Exp))
;
(* Rule 30, file Parser.grm, line 95 *)
val _ = update_ yyact 30
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.And ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 31, file Parser.grm, line 96 *)
val _ = update_ yyact 31
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Or ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 32, file Parser.grm, line 102 *)
val _ = update_ yyact 32
(fn () => repr(let
val d__1__ = peekVal 1 : string*(int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Apply (#1 (d__1__), (d__2__), #2 (d__1__)) ) end : Cat.Exp))
;
(* Rule 33, file Parser.grm, line 103 *)
val _ = update_ yyact 33
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Read (d__1__) ) end : Cat.Exp))
;
(* Rule 34, file Parser.grm, line 104 *)
val _ = update_ yyact 34
(fn () => repr(let
val d__1__ = peekVal 1 : (int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Write ((d__2__), (d__1__)) ) end : Cat.Exp))
;
(* Rule 35, file Parser.grm, line 105 *)
val _ = update_ yyact 35
(fn () => repr(let
val d__1__ = peekVal 2 : (int*int)
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( (d__2__) ) end : Cat.Exp))
;
(* Rule 36, file Parser.grm, line 109 *)
val _ = update_ yyact 36
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Exp
in
( [(d__1__)] ) end : Cat.Exp list))
;
(* Rule 37, file Parser.grm, line 110 *)
val _ = update_ yyact 37
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp list
in
( (d__1__) :: (d__3__) ) end : Cat.Exp list))
;
(* Entry Prog *)
val _ = update_ yyact 38 (fn () => raise yyexit (peekVal 0));
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
