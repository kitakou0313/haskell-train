-- Haskellの関数定義 {func name} {param} = {function def}
doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y

-- if statementはelse必須 
doubleSmallNumber x = if x > 100 then x else x*2
-- if statementもexpression（valueを返すもの）の一種->なんらかの値を返すものと見なせるので以下のように書ける
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1