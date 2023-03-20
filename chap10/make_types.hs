import System.Posix (FlowAction)
-- 独自の型の定義
-- dataを使用する
data OwnBool = True | False
-- =の右側はvalue constructorと呼ばれる
-- 型に含まれる値を定義している
-- ほんとに集合の定義みたいだぁ…

-- Value constructor内でさらに別のValue constructorを定義できる
-- Shape型はCircleとRectagnleのValue constructorで作られる値を含められる
data Shape = Circle Float Float Float | Rectangle Float Float Float Float

-- value constructorも関数である
-- 引数を3つ取ってShape型の値を返す関数
-- ghci> :t Circle 
-- Circle :: Float -> Float -> Float -> Shape

-- 関数定義などではValue constructorは使えない
-- 値として扱われるので、True -> Intみたいに書けないのと同じ理由
-- Value constructor = リテラルみたいなイメージ?
surface :: Shape -> Float
-- value constructorをpattern matchingに使用できる
surface (Circle _ _ r) = pi * r ^2
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)