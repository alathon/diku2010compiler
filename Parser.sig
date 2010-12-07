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

val Prog :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Cat.Prog;
