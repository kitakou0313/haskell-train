-- Haskellの関数定義 {func name} {param} = {function def}
doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y

-- if statementはelse必須 
doubleSmallNumber x = if x > 100 then x else x*2
-- if statementもexpression（valueを返すもの）の一種->なんらかの値を返すものと見なせるので以下のように書ける
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs , odd x]

length' xs = sum [1| _ <- xs]
-- 内包表記

removeNonUpperCase st = [c | c <- st, c `elem` ['A'..'Z']]

-- tuple in haskell
-- 格納するvalueのtype, 個数毎に型をもつ
-- すべてのtupleに使えるような関数は定義できない
-- listには同じ型のvalueしか格納できないので[(1,"Hoge"), (2,3)]みたいなことはできない

zip' = zip [1..] [2..10]
-- 無限長listを扱えるのでこういうこともできる

triangles = [(a,b,c) | a <- [1..10], b <- [1..10], c <- [1..10], c^2 == a^2 + b^2, a+b+c == 24]
-- 基本的なfunctional programingの一例
-- solutionの一覧を列挙, filter用の変換を定義, 最終的な答えを返す