import System.Posix (FlowAction)
-- 独自の型の定義
-- dataを使用する
data OwnBool = True | False
-- =の右側はvalue constructorと呼ばれる
-- 型に含まれる値を定義している
-- ほんとに集合の定義みたいだぁ…

-- Value constructor内でさらに別のValue constructorを定義できる
-- Shape型はCircleとRectagnleのValue constructorで作られる値を含められる
-- 定義した型を他の型の一部にする場合はderivingを用いる
data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)

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

surfaceCircle = surface $ Circle 10 20 10
surfaceRectangle = surface $ Rectangle 0 0 100 100

-- Value constructorsは関数なので、カリー化もmapでの適用もできる
concentricCircles = map (Circle 10 20) [4,5,6,7]