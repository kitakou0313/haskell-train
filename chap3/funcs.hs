removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c|c <- st, c `elem` ['A'..'Z']]

-- 最初3つが引数の型、最後が返り値の型
addThree::Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- 型変数
-- 関数などの定義時に型名を代入できる変数
-- 下のbなど
-- 型変数を用いて定義された関数をpolymorphic functionsと呼ぶ

-- type class
-- 変数が満たしているべき性質 OOPでのinterfaceのイメージ
-- 下の例なら Num bはbは数値として振舞えるクラス
fromIntegral' :: (Num b, Integral a) => a -> b

-- 型を以下の形で指定できる
-- read :: Read a => String -> a Read type classの型変数aの値をIntegerに固定する

-- ghci> :t read "4" :: Integer 
-- read "4" :: Integer :: Integer
-- ghci> :t read "4" :: Float
-- read "4" :: Float :: Float