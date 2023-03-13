-- 関数を返り値、引数のように扱う関数を高階関数と呼ぶ
-- Haskellで定義される関数は実際には一つの引数しか取らない
-- 複数の引数を取る関数は全てcurry化という仕組みを使っている

-- Curried functions
-- 以下の呼び出しは等価

max4 = max 4 5
max4' = (max 4) 5
-- スペースは演算子の一種のようなものであり、最も高い優先度をもつ

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
-- 関数は左からスペースによって適用されるので()が必要 f f x = (f f) xになる
applyTwice f x = f (f x)

-- applyTwice' :: (a -> a) -> a
-- applyTwice' f = f f


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

-- $での関数適用
-- +などと同じ演算子の一種、($) :: (a -> b) -> a -> b として関数としても見れる
-- スペースによる関数適用は左結合（left-associative） f a b c = ((f a) b) c
-- $を用いると右結合になる=右側が優先される
-- 優先度が最も低くなる

-- 以下二つは同じ
rootOfSum = sqrt (3 + 4 + 9)
rootOfSum' = sqrt $ 3 + 4 + 9

filterWithDollar = sum (filter (> 10) (map (*2) [2..10]))
filterWithDollar' :: Integer
filterWithDollar' = sum $ filter (> 10) $ map (*2) [2..10]

-- 関数合成 functional decomposition
-- 二つの関数を合成して一つの関数とする
-- f (g x) = (f ○ g) x

-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \x -> f $ g x

-- lambda関数と似たようなことができるが、こっちのほうが可読性が高い
negatedNumbers = map (negate . abs) [1,2,3,4]

-- 右結合
negatedSumOfNumbers = map (negate.abs.sum) [[1..5], [10..20],[30..40]]

-- 複数引数を取る関数の合成
-- 一つの引数を取るように部分的に適用しなければならない
sumReplicateMax = sum (replicate 5 (max 6.7 8.9))
sumReplicateMax' = (sum . replicate 5 . max 6.7) 8.9
-- 下では「max 6.7の引数を引数とし、結果をreplicate 5に渡して返り値をsumの引数とする」関数が定義され、8.9を引数として実行されている
sumReplicateMax'' = sum . replicate 5 . max  6.7 $ 8.9

-- 複数の括弧で構成された関数を関数合成で書き直せる
functionCompSample = replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))
functionCompSample' = replicate 100 . product . map (*3) . zipWith max [1,2,3,4,5] $ [4,5,6,7,8]


-- function compositionは関数のpointless styleでの定義にでも使用可能
sum'' ::(Num a) => [a] -> a
sum'' xs = foldl (+) 0 xs
-- carry化により以下のように書ける
sum''' ::(Num a) => [a] -> a
sum''' = foldl (+) 0

-- 括弧に含まれているため引数を除けない場合も、function compositionを用いて定義することで引数を除ける
fn  = ceiling . negate . tan . cos . max 50
fn' x = ceiling (negate (tan (cos (max 50 x))))

-- 関数合成をしすぎると可読性が悪化するため、適切に中間結果を変数にletなどを用いて束縛するべき
oddSquareSum :: Integer
oddSquareSum = sum . takeWhile (<10000) . filter odd . map (^2) $ [1..]

oddSquareSum' :: Integer
oddSquareSum' = 
    let oddSquares = filter odd $ map (^2) [1..]
        belowLimit = takeWhile (<10000) oddSquares
    in sum belowLimit