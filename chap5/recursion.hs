-- Haskellにはwhile, for loopがない
-- 代わりに再帰関数を用いる

-- 再帰関数...関数の定義に定義される関数自身が含まれる関数

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Empty list!"
maximum' [x] = x
maximum'(x:xs)
    | x > maxTail = x
    | otherwise = maxTail
    where maxTail = maximum' xs

maximum'' ::(Ord a) => [a] -> a
maximum'' [] = error "Empty list!"
maximum'' [x] = x
maximum'' (x:xs) = max x (maximum'' xs)

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' i a
    | i <= 0 = []
    | otherwise = a:replicate' (i-1) a

-- 関数の引数を考え、その引数ごとにエッジケースを考えると良さそう
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x:take' (n-1) xs 

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- 無限長リストも扱える
repeat' :: a -> [a]
repeat' x = x:repeat' x

zip' ::[a] -> [b] -> [(a,b)]
zip' [] _ = [] 
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = elem' a xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted

-- edge caseの値は恒等式に対応することがある
-- sum [a] なら[]に対応する値は0
-- 残りの値に0を足しても変化しないので
-- sortなら sort []は[]

-- 再帰的に考えるときは
-- 1.再帰的に実行できないケースを考える
-- edge caseにできないか考える
-- edge caseの値として恒等式の値を採用できないか考える
-- pattern matchでどのように再帰的に分割して適用していくか考える