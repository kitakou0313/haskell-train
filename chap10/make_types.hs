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

-- 中間のデータ型を定義して可読性を上げる
-- 型に含まれるValue Constructorが一つだけの場合は型名と同じにするのが一般的
data Point = Point Float Float deriving (Show)
data Shape2 = Circle2 Point Float | Rectangle2 Point Point deriving (Show)

-- Value Constructorによるpattern matchはnestして使える
surface2 :: Shape2 -> Float
surface2 (Circle2 _ r) = pi * r ^ 2
surface2 (Rectangle2 (Point x1 y1) (Point x2 y2)) = (abs $ x1 - x2) * (abs $ y1 - y2)

nudge :: Shape2 -> Float -> Float -> Shape2
nudge (Circle2 (Point x y) r) a b = Circle2 (Point (x+a) (y+b)) r
nudge (Rectangle2 (Point x1 y1) (Point x2 y2)) a b = Rectangle2 (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2+b))
