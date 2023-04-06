import qualified Data.List as List
 
--  第二引数で与えられたリストの要素の間に第一引数の要素を入れる
res = List.intersperse '.' "MONKEY"

-- listの間にリストを入れて結合する
res2 = List.intercalate [0,0] [[1,2,3],[4,5,6]]

-- 2D行列を転置する
res3 = List.transpose [[1,2,3],[4,5,6],[7,8,9]]
res4 = map sum $ List.transpose [[0,3,5,9],[10,0,0,9],[8,5,1,-1]]

-- リスト内要素の結合
res5 = List.concat ["foo", "bar", "cat"]
res6 = List.concat [[3,4,5],[2,3,4]]

-- mapして得られたlist in listを結合
res7 = List.concatMap (replicate 4) [1..3]

-- list内のbool値すべてに対して演算する
res8 = and $ map (>4) [5,6,7,8]
res9 = or $ map (>4) [1,2,3,5,6,7]

-- 実際はanyとallが代わりに使われる
res10 = any (==4) [1,2,3,4]
res11 = all (==4) [1,2,3,4]

-- 初期値と関数を取り，無限長リストを生成
res12 = take 10 $ List.iterate (*2) 1
-- [1,2,4,8]