local open Obj Lexing in


 open Lexing;

 exception LexicalError of string * (int * int) (* (message, (line, column)) *)

 val currentLine = ref 1
 val lineStartPos = ref [0]

 fun getPos lexbuf = getLineCol (getLexemeStart lexbuf)
				(!currentLine)
				(!lineStartPos)

 and getLineCol pos line (p1::ps) =
       if pos>=p1 then (line, pos-p1)
       else getLineCol pos (line-1) ps
   | getLineCol pos line [] = raise LexicalError ("",(0,0))

 fun lexerError lexbuf s = 
     raise LexicalError (s, getPos lexbuf)

 fun keyword (s, pos) =
     case s of
         "end"          => Parser.END pos
       | "int"          => Parser.INT pos
       | "bool"         => Parser.BOOL pos
       | "true"         => Parser.TRUE pos
       | "false"        => Parser.FALSE pos
       | "fun"          => Parser.FUN pos
       | "read"         => Parser.READ pos
       | "write"        => Parser.WRITE pos
       | _              => Parser.ID (s, pos)

 
fun action_18 lexbuf = (
 lexerError lexbuf "Illegal symbol in input" )
and action_17 lexbuf = (
 Parser.EOF (getPos lexbuf) )
and action_16 lexbuf = (
 Parser.BAR (getPos lexbuf) )
and action_15 lexbuf = (
 Parser.MATCHARROW (getPos lexbuf) )
and action_14 lexbuf = (
 Parser.ARROW (getPos lexbuf) )
and action_13 lexbuf = (
 Parser.COMMA (getPos lexbuf) )
and action_12 lexbuf = (
 Parser.SEMICOLON (getPos lexbuf) )
and action_11 lexbuf = (
 Parser.COLON (getPos lexbuf) )
and action_10 lexbuf = (
 Parser.RPAR (getPos lexbuf) )
and action_9 lexbuf = (
 Parser.LPAR (getPos lexbuf) )
and action_8 lexbuf = (
 Parser.MINUS (getPos lexbuf) )
and action_7 lexbuf = (
 Parser.PLUS (getPos lexbuf) )
and action_6 lexbuf = (
 keyword (getLexeme lexbuf,getPos lexbuf) )
and action_5 lexbuf = (
 case Int.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad integer"
                             | SOME i => Parser.NUM (i, getPos lexbuf) )
and action_4 lexbuf = (
 Parser.FALSE (getPos lexbuf) )
and action_3 lexbuf = (
 Parser.TRUE (getPos lexbuf) )
and action_2 lexbuf = (
 currentLine := !currentLine+1;
                          lineStartPos :=  getLexemeStart lexbuf
			                   :: !lineStartPos;
                          Token lexbuf )
and action_1 lexbuf = (
 Token lexbuf )
and action_0 lexbuf = (
 Token lexbuf )
and state_0 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"A" andalso currChar <= #"Z" then  state_15 lexbuf
 else if currChar >= #"g" andalso currChar <= #"s" then  state_15 lexbuf
 else if currChar >= #"u" andalso currChar <= #"z" then  state_15 lexbuf
 else if currChar >= #"0" andalso currChar <= #"9" then  state_11 lexbuf
 else case currChar of
    #"e" => state_15 lexbuf
 |  #"d" => state_15 lexbuf
 |  #"c" => state_15 lexbuf
 |  #"b" => state_15 lexbuf
 |  #"a" => state_15 lexbuf
 |  #"\t" => state_3 lexbuf
 |  #"\r" => state_3 lexbuf
 |  #" " => state_3 lexbuf
 |  #"\n" => action_2 lexbuf
 |  #"\f" => action_2 lexbuf
 |  #"|" => action_16 lexbuf
 |  #"t" => state_17 lexbuf
 |  #"f" => state_16 lexbuf
 |  #"=" => state_14 lexbuf
 |  #";" => action_12 lexbuf
 |  #":" => action_11 lexbuf
 |  #"/" => state_10 lexbuf
 |  #"-" => state_9 lexbuf
 |  #"," => action_13 lexbuf
 |  #"+" => action_7 lexbuf
 |  #")" => action_10 lexbuf
 |  #"(" => action_9 lexbuf
 |  #"\^@" => action_17 lexbuf
 |  _ => action_18 lexbuf
 end)
and state_3 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_0);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\t" => state_31 lexbuf
 |  #"\r" => state_31 lexbuf
 |  #" " => state_31 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_9 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_8);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #">" => action_14 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_10 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_18);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"/" => state_29 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_11 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_5);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_28 lexbuf
 else backtrack lexbuf
 end)
and state_14 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_18);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #">" => action_15 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_15 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_16 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"b" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"a" => state_23 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_17 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"q" then  state_19 lexbuf
 else if currChar >= #"s" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"r" => state_20 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_19 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_20 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"t" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"z" => state_19 lexbuf
 |  #"y" => state_19 lexbuf
 |  #"x" => state_19 lexbuf
 |  #"w" => state_19 lexbuf
 |  #"v" => state_19 lexbuf
 |  #"u" => state_21 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_21 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"f" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"d" => state_19 lexbuf
 |  #"c" => state_19 lexbuf
 |  #"b" => state_19 lexbuf
 |  #"a" => state_19 lexbuf
 |  #"e" => state_22 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_22 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_3);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_23 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"k" then  state_19 lexbuf
 else if currChar >= #"m" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"l" => state_24 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_24 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"r" then  state_19 lexbuf
 else if currChar >= #"t" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"s" => state_25 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_25 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_6);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"f" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  #"d" => state_19 lexbuf
 |  #"c" => state_19 lexbuf
 |  #"b" => state_19 lexbuf
 |  #"a" => state_19 lexbuf
 |  #"e" => state_26 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_26 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_19 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_19 lexbuf
 else case currChar of
    #"_" => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_28 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_5);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_28 lexbuf
 else backtrack lexbuf
 end)
and state_29 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_1);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\^@" => backtrack lexbuf
 |  #"\n" => backtrack lexbuf
 |  _ => state_29 lexbuf
 end)
and state_31 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_0);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\t" => state_31 lexbuf
 |  #"\r" => state_31 lexbuf
 |  #" " => state_31 lexbuf
 |  _ => backtrack lexbuf
 end)
and Token lexbuf =
  (setLexLastAction lexbuf (magic dummyAction);
   setLexStartPos lexbuf (getLexCurrPos lexbuf);
   state_0 lexbuf)

(* The following checks type consistency of actions *)
val _ = fn _ => [action_18, action_17, action_16, action_15, action_14, action_13, action_12, action_11, action_10, action_9, action_8, action_7, action_6, action_5, action_4, action_3, action_2, action_1, action_0];

end
