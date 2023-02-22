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