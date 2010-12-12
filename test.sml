fun test [] = NONE
  | test a  = SOME 1

fun nice l =
  let
    val result = test l
  in
    1
  end

nice [1,2,3]
