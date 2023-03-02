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