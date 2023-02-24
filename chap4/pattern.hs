-- 関数のpattern match
-- 与えられる引数ごとに実行される関数の定義を変える

lucky :: (Integral a ) => a -> String
lucky 7 = "Lucky number seven!"
lucky x = "Sorry, you are out of luck!"

-- 上から評価される
-- そのため全ケースが該当するパターンを先頭にもってくると無限ループを招く
-- 個々のパターンが先、より汎用的なパターンを最後にする
-- すべてのパターンを列挙できているかが重要
factorial :: (Integral a ) => a -> a
factorial 0 = 1
factorial n = n * factorial(n-1)

charName :: Char -> String
charName 'a' = "Albert"
charName 'b' = "Broseph"
charName 'c' = "Cecil"

-- pattarn matchingを使った二次元ベクトルの加算
addVectors :: (Num a ) => (a, a) -> (a,a) -> (a,a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1+y2)

-- 複数bindする場合は()必須
first :: (a, b, c) -> a
first(x,_,z) = x

head' :: [a] -> a
head' [] = error "Error!"
head' (x:_) = x

-- listを使ったpattern matching
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one elem" ++ show x
tell (x:y:[]) = "The list has two elems" ++ show x ++ " " ++ show y
tell (x:y:_) = "The list has onw elem" ++ show x

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- patterns データ全体を保ちながら各変数に分割
capital :: String -> String
capital "" = "Empty String"
capital all@(x:xs) = "The first is" ++ show x ++ " The whole string is " ++ show all