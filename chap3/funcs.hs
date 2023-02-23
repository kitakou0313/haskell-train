removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c|c <- st, c `elem` ['A'..'Z']]

-- 最初3つが引数の型、最後が返り値の型
addThree::Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- type class
-- 変数が満たしているべき性質 OOPでのinterfaceのイメージ
-- 下の例なら Num bはbは数値として振舞えるクラス
fromIntegral' :: (Num b, Integral a) => a -> b
