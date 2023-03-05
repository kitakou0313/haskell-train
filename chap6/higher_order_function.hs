-- 関数を返り値、引数のように扱う関数を高階関数と呼ぶ
-- Haskellで定義される関数は実際には一つの引数しか取らない

-- Curried functions
-- 以下の呼び出しは等価

-- max 4 5
-- (max 4) 5

-- 下は(max 4)で「引数一つを取り、4と引数の内どちらか大きい方を返す」関数を返し、それを5に適用している
-- max :: Ord a => a -> a -> aをmax :: Ord a => a -> (a -> a)とみている
-- Haskellでは右結合なので

-- カリー化（curried function）
-- 複数の引数をもつ関数を、最初の引数を引数とし返り値として
-- 関数（元の関数の最初の引数以外を受け取り残り実行する）を返す関数とすること
multTheee :: (Num a) => a -> a -> a -> a
multTheee x y z = x * y * z

-- x は両辺に現れてるだけなので消せる
compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x

-- 引数無しで、aを受けとり比較結果を返す関数として定義
-- 100の型はNumのtype classに含まれるのでtype classにNumが含まれてる
compareWithHundred' :: (Num a, Ord a) => a -> Ordering
compareWithHundred' = compare 100

-- 関数を引数にとる関数の定義
-- 関数を引数として取るので、関数の型定義時には明示的に括弧をつけて型を定義している
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys 

-- 型定義がわからないときは:tなどで推論された型定義を見るとよい

flip'' :: (a -> b -> c) -> (b -> a -> c)  
flip'' f = g  
    where g x y = f y x 

flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

-- higher order functionの例

-- map関数
-- 配列の各要素に関数を適用したものの配列を返す
-- JSとかで見るやつと同じ
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map f xs

-- filter関数
-- 配列の各要素に対してbool値を返す関数（predicate、述語）を用いて、配列の要素をフィルタリング
-- JSとかで見るやつと同じ
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x = x:rest
    | otherwise = rest
    where rest = filter' f xs

quicksort' :: (Ord a) => [a] -> [a]
quicksort' [] = []
quicksort' (x:xs) =
    let smallerSorted = quicksort' (filter (<=x) xs)
        biggerSorted = quicksort' (filter' (>x) xs)
    in smallerSorted ++ [x] ++ biggerSorted


largestDivisible ::(Integral a) => a
largestDivisible = head  (filter p [100000, 99999..])
        where p x = (x `mod` 3829) == 0

sumAllOddSquares :: (Integral a) => a
sumAllOddSquares = sum (
    takeWhile (<10000) (filter odd (map (^2) [1..])))

sumAllOddSquares' ::(Integral a) => a
sumAllOddSquares' = sum(
    takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])

chain :: (Integral a) => a -> [a]
chain 1 = []
chain n
    | even n = n:chain (n `div` 2)
    | odd n = n:chain(n * 3 + 1)

numLongChains :: Int
numLongChains = length(filter isLongChain [chain n | n <- [1..100]])
    where isLongChain xs = length xs > 15

-- 引数を複数とる関数をmapに渡すことでcurried functionのlistを作れる
listOfFunx = map (*) [0..]

-- lambda...無名関数
numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))

zipWithLambda = zipWith (\a b -> a + b) [1,2,3] [4,5,6]

-- 通常の関数と同じくpattern matchingも使える
-- 引数のパターンによる分岐はできないので注意
-- []と(x:xs)など
mappedLambda = map (\(a,b) -> a + b) [(1,2), (3,4), (5,6),(7,8)]

-- lambdaの使いどころ
-- 一度しか使用しない関数を定義するとき
-- 関数そのものを返すことを表したいとき
flip''' :: (a -> b -> c) -> b -> a -> c
flip''' f = \a b -> f b a

-- fold関数...リストに対する再帰処理の実装を簡単にしてくれる
-- 二項関数(binary function),初期値,再帰的に適用するlistの三つを引数に取る
-- 前の要素までの結果を格納したacc、今の要素が入るxを二項関数に適用し、次のaccとする
-- foldlは左から
sum' :: (Num a) => [a] -> a
-- sum' xs = foldl (\acc x -> acc + x) 0 xs
sum' = foldl (+) 0

-- foldrは右から
-- 二項関数の引数の順番も逆になる
map''::(a -> b) -> [a] -> [b]
map'' f xs = foldr (\x acc -> (f x): acc) [] xs

-- foldrのみ無限長リストを扱える（終端が決まってから実行できるので）
-- fold関数はリストを要素ごと横断する任意の関数の実装に使える
-- foldl1, foldr1などは配列の先頭、終端の値を初期値としてfoldを行う
-- empty listを入力されるとruntime errorなので注意

maximum' ::(Ord a) => [a] -> a
maximum' = foldl1 (\acc x -> if x > acc then x else acc)

reverse'::[a] -> [a]
reverse' = foldl (\acc x -> x:acc) []

filter'' :: (a -> Bool) -> [a] -> [a]
filter'' f = foldr (\x acc -> if f x then x:acc else acc) []

-- scan...foldのaccの中間状態をリストにして出力
sumOfListWithScanl = scanl (+) 0 [1,2,3]
sumOfListWithScanl1 = scanl1 (+) [1,2,3]


sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1