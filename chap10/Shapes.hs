module Shapes
(
    Point(..),
    Shape2(..),
    surface2,
    nudge
) where
-- 型（Value constructor）とすることでエクスポートできる
-- Value Constructorをエクスポートしないとpattern matchできなくなる点は注意

data Point = Point Float Float deriving (Show)
data Shape2 = Circle2 Point Float | Rectangle2 Point Point deriving (Show)

-- Value Constructorによるpattern matchはnestして使える
surface2 :: Shape2 -> Float
surface2 (Circle2 _ r) = pi * r ^ 2
surface2 (Rectangle2 (Point x1 y1) (Point x2 y2)) = (abs $ x1 - x2) * (abs $ y1 - y2)

nudge :: Shape2 -> Float -> Float -> Shape2
nudge (Circle2 (Point x y) r) a b = Circle2 (Point (x+a) (y+b)) r
nudge (Rectangle2 (Point x1 y1) (Point x2 y2)) a b = Rectangle2 (Point (x1 + a) (y1 + b)) (Point (x2 + a) (y2+b))
