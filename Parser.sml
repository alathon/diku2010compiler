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
type t__15__ = (int*int)
type t__16__ = string*(int*int)
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
type t__33__ = (int*int)
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
  | GT of t__15__
  | ID of t__16__
  | IN of t__17__
  | INT of t__18__
  | LET of t__19__
  | LPAR of t__20__
  | LT of t__21__
  | MATCHARROW of t__22__
  | MINUS of t__23__
  | NOT of t__24__
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
  271 (* GT *),
  272 (* ID *),
  273 (* IN *),
  274 (* INT *),
  275 (* LET *),
  276 (* LPAR *),
  277 (* LT *),
  278 (* MATCHARROW *),
  279 (* MINUS *),
  280 (* NOT *),
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
\\003\000\003\000\007\000\007\000\007\000\007\000\008\000\008\000\
\\006\000\006\000\004\000\004\000\004\000\004\000\004\000\004\000\
\\004\000\004\000\004\000\004\000\005\000\005\000\000\000";

val yylen = "\002\000\
\\004\000\007\000\000\000\009\000\000\000\001\000\001\000\001\000\
\\001\000\003\000\001\000\001\000\001\000\001\000\001\000\003\000\
\\003\000\003\000\001\000\001\000\001\000\001\000\003\000\003\000\
\\002\000\001\000\002\000\003\000\001\000\003\000\002\000";

val yydefred = "\000\000\
\\000\000\000\000\000\000\031\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\021\000\000\000\000\000\019\000\026\000\020\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\\000\000\000\000\007\000\008\000\006\000\000\000\000\000\000\000\
\\028\000\000\000\000\000\000\000\000\000\000\000\010\000\002\000\
\\000\000\013\000\012\000\011\000\014\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\004\000\000\000";

val yydgoto = "\002\000\
\\004\000\030\000\031\000\018\000\000\000\046\000\047\000\000\000\
\\005\000\008\000";

val yysindex = "\003\000\
\\230\254\000\000\251\254\000\000\005\255\008\255\007\255\056\255\
\\011\255\020\255\000\000\056\255\056\255\000\000\000\000\000\000\
\\056\255\035\255\027\255\027\255\000\000\026\255\000\000\000\000\
\\056\255\056\255\000\000\000\000\000\000\042\255\021\255\033\255\
\\000\000\000\000\000\000\027\255\230\254\027\255\000\000\000\000\
\\246\254\000\000\000\000\000\000\000\000\079\255\031\255\246\254\
\\005\255\056\255\051\255\000\000\043\255";

val yyrindex = "\000\000\
\\048\255\000\000\000\000\000\000\071\255\000\000\000\000\000\000\
\\000\000\000\000\000\000\254\254\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\006\255\000\000\014\255\000\000\
\\000\000\000\000\000\000\000\000\000\000\040\255\000\000\000\000\
\\000\000\029\255\037\255\000\000\048\255\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\071\255\000\000\064\255\000\000\082\255";

val yygindex = "\000\000\
\\000\000\248\255\039\000\244\255\000\000\030\000\000\000\000\000\
\\042\000\044\000";

val YYTABLESIZE = 105;
val yytable = "\021\000\
\\022\000\022\000\042\000\001\000\023\000\043\000\003\000\022\000\
\\022\000\025\000\006\000\032\000\034\000\035\000\044\000\025\000\
\\025\000\027\000\007\000\009\000\022\000\045\000\010\000\027\000\
\\027\000\022\000\020\000\022\000\025\000\041\000\019\000\027\000\
\\024\000\025\000\038\000\025\000\027\000\053\000\024\000\024\000\
\\023\000\027\000\028\000\027\000\029\000\024\000\023\000\023\000\
\\025\000\036\000\037\000\024\000\050\000\026\000\048\000\033\000\
\\024\000\025\000\024\000\023\000\003\000\003\000\026\000\003\000\
\\023\000\025\000\023\000\003\000\011\000\009\000\026\000\012\000\
\\003\000\018\000\039\000\013\000\003\000\051\000\040\000\003\000\
\\014\000\003\000\048\000\005\000\015\000\017\000\005\000\016\000\
\\049\000\017\000\005\000\017\000\052\000\000\000\000\000\005\000\
\\000\000\000\000\000\000\005\000\000\000\000\000\005\000\000\000\
\\005\000";

val yycheck = "\012\000\
\\013\000\004\001\013\001\001\000\017\000\016\001\033\001\010\001\
\\011\001\004\001\016\001\020\000\025\000\026\000\025\001\010\001\
\\011\001\004\001\014\001\012\001\023\001\032\001\016\001\010\001\
\\011\001\028\001\007\001\030\001\023\001\038\000\020\001\005\001\
\\004\001\028\001\002\001\030\001\023\001\050\000\010\001\011\001\
\\004\001\028\001\016\001\030\001\018\001\011\001\010\001\011\001\
\\023\001\008\001\030\001\023\001\022\001\028\001\004\001\030\001\
\\028\001\023\001\030\001\023\001\013\001\014\001\028\001\016\001\
\\028\001\023\001\030\001\020\001\013\001\030\001\028\001\016\001\
\\025\001\010\001\036\000\020\001\029\001\048\000\037\000\032\001\
\\025\001\034\001\004\001\013\001\029\001\004\001\016\001\032\001\
\\010\001\034\001\020\001\010\001\049\000\255\255\255\255\025\001\
\\255\255\255\255\255\255\029\001\255\255\255\255\032\001\255\255\
\\034\001";

val yyact = vector_ 32 (fn () => ((raise Fail "parser") : obj));
(* Rule 1, file Parser.grm, line 42 *)
val _ = update_ yyact 1
(fn () => repr(let
val d__1__ = peekVal 3 : Cat.TyDec list
val d__2__ = peekVal 2 : Cat.FunDec list
val d__3__ = peekVal 1 : Cat.Exp
val d__4__ = peekVal 0 : (int*int)
in
( ((d__1__),(d__2__),(d__3__)) ) end : Cat.Prog))
;
(* Rule 2, file Parser.grm, line 46 *)
val _ = update_ yyact 2
(fn () => repr(let
val d__1__ = peekVal 6 : (int*int)
val d__2__ = peekVal 5 : string*(int*int)
val d__3__ = peekVal 4 : (int*int)
val d__4__ = peekVal 3 : (int*int)
val d__5__ = peekVal 2 : Cat.Type list
val d__6__ = peekVal 1 : (int*int)
val d__7__ = peekVal 0 : Cat.TyDec list
in
( (#1 (d__2__), (d__5__), (d__1__)) :: (d__7__) ) end : Cat.TyDec list))
;
(* Rule 3, file Parser.grm, line 47 *)
val _ = update_ yyact 3
(fn () => repr(let
in
( [] ) end : Cat.TyDec list))
;
(* Rule 4, file Parser.grm, line 51 *)
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
(* Rule 5, file Parser.grm, line 52 *)
val _ = update_ yyact 5
(fn () => repr(let
in
( [] ) end : Cat.FunDec list))
;
(* Rule 6, file Parser.grm, line 56 *)
val _ = update_ yyact 6
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Int (d__1__) ) end : Cat.Type))
;
(* Rule 7, file Parser.grm, line 57 *)
val _ = update_ yyact 7
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Bool (d__1__) ) end : Cat.Type))
;
(* Rule 8, file Parser.grm, line 58 *)
val _ = update_ yyact 8
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.TyVar (d__1__) ) end : Cat.Type))
;
(* Rule 9, file Parser.grm, line 61 *)
val _ = update_ yyact 9
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Type
in
( [(d__1__)] ) end : Cat.Type list))
;
(* Rule 10, file Parser.grm, line 62 *)
val _ = update_ yyact 10
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Type
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Type list
in
( (d__1__) :: (d__3__) ) end : Cat.Type list))
;
(* Rule 11, file Parser.grm, line 65 *)
val _ = update_ yyact 11
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.NumP (d__1__) ) end : Cat.Pat))
;
(* Rule 12, file Parser.grm, line 66 *)
val _ = update_ yyact 12
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.VarP (d__1__) ) end : Cat.Pat))
;
(* Rule 13, file Parser.grm, line 67 *)
val _ = update_ yyact 13
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.FalseP (d__1__) ) end : Cat.Pat))
;
(* Rule 14, file Parser.grm, line 68 *)
val _ = update_ yyact 14
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.TrueP (d__1__) ) end : Cat.Pat))
;
(* Rule 15, file Parser.grm, line 71 *)
val _ = update_ yyact 15
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Pat
in
( [(d__1__)] ) end : Cat.Pat list))
;
(* Rule 16, file Parser.grm, line 72 *)
val _ = update_ yyact 16
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Pat list
in
( (d__1__) :: (d__3__) ) end : Cat.Pat list))
;
(* Rule 17, file Parser.grm, line 76 *)
val _ = update_ yyact 17
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( [((d__1__),(d__3__))] ) end : Cat.Match))
;
(* Rule 18, file Parser.grm, line 78 *)
val _ = update_ yyact 18
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Match
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Match
in
( (d__1__) @ (d__3__) ) end : Cat.Match))
;
(* Rule 19, file Parser.grm, line 81 *)
val _ = update_ yyact 19
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.Num (d__1__) ) end : Cat.Exp))
;
(* Rule 20, file Parser.grm, line 82 *)
val _ = update_ yyact 20
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.True (d__1__) ) end : Cat.Exp))
;
(* Rule 21, file Parser.grm, line 83 *)
val _ = update_ yyact 21
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.False (d__1__) ) end : Cat.Exp))
;
(* Rule 22, file Parser.grm, line 84 *)
val _ = update_ yyact 22
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.Var (d__1__) ) end : Cat.Exp))
;
(* Rule 23, file Parser.grm, line 85 *)
val _ = update_ yyact 23
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Plus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 24, file Parser.grm, line 86 *)
val _ = update_ yyact 24
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Minus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 25, file Parser.grm, line 88 *)
val _ = update_ yyact 25
(fn () => repr(let
val d__1__ = peekVal 1 : string*(int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Apply (#1 (d__1__), (d__2__), #2 (d__1__)) ) end : Cat.Exp))
;
(* Rule 26, file Parser.grm, line 89 *)
val _ = update_ yyact 26
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Read (d__1__) ) end : Cat.Exp))
;
(* Rule 27, file Parser.grm, line 90 *)
val _ = update_ yyact 27
(fn () => repr(let
val d__1__ = peekVal 1 : (int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Write ((d__2__), (d__1__)) ) end : Cat.Exp))
;
(* Rule 28, file Parser.grm, line 91 *)
val _ = update_ yyact 28
(fn () => repr(let
val d__1__ = peekVal 2 : (int*int)
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( (d__2__) ) end : Cat.Exp))
;
(* Rule 29, file Parser.grm, line 95 *)
val _ = update_ yyact 29
(fn () => repr(let
val d__1__ = peekVal 0 : Cat.Exp
in
( [(d__1__)] ) end : Cat.Exp list))
;
(* Rule 30, file Parser.grm, line 96 *)
val _ = update_ yyact 30
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp list
in
( (d__1__) :: (d__3__) ) end : Cat.Exp list))
;
(* Entry Prog *)
val _ = update_ yyact 31 (fn () => raise yyexit (peekVal 0));
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
