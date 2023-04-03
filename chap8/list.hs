import qualified Data.List as List
 
--  第二引数で与えられたリストの要素の間に第一引数の要素を入れる
res = List.intersperse '.' "MONKEY"

-- listの間にリストを入れて結合する
res2 = List.intercalate [0,0] [[1,2,3],[4,5,6]]