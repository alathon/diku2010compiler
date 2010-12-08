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
type t__25__ = string*(int*int)
type t__26__ = int*(int*int)
type t__27__ = (int*int)
type t__28__ = (int*int)
type t__29__ = (int*int)
type t__30__ = (int*int)
type t__31__ = (int*int)
type t__32__ = (int*int)
type t__33__ = (int*int)
type t__34__ = string*(int*int)
type t__35__ = (int*int)
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
  | NULL of t__25__
  | NUM of t__26__
  | OF of t__27__
  | OR of t__28__
  | PLUS of t__29__
  | READ of t__30__
  | RPAR of t__31__
  | SEMICOLON of t__32__
  | TRUE of t__33__
  | TYPE of t__34__
  | WRITE of t__35__
end;

val Prog :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Cat.Prog;
