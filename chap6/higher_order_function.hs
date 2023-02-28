-- 関数を返り値、引数のように扱う関数を高階関数と呼ぶ

-- Curried functions
-- 以下の呼び出しは等価

-- max 4 5
-- (max 4) 5

-- 下は(max 4)で「引数一つを取り、4と引数の内どちらか大きい方を返す」関数を返し、それを5に適用している
-- max :: Ord a => a -> a -> aをmax :: Ord a => a -> (a -> a)とみている

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