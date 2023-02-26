-- guard... switchに近い記法で引数によるpatternが記述できる
bimTell :: (RealFloat a) => a -> a -> String
bimTell weight height
 | weight / (height^2) <= 18.5 = "You're underweight, you emo, you!"
 | weight / (height^2) <= 25.0 = "You're underweight, you emo, you!"
 | weight / (height^2) <= 30.0 = "You're underweight, you emo, you!"
 | otherwise = "Your nice!"

max' :: (Ord a) => a -> a -> a
max' a b
 | a > b = a
 | otherwise = b

-- where文でguard内で使える変数にbindできる
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
 | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / (height ^ 2)
          (skinny, normal, fat) = (18.5, 25.0, 30.0)  

-- where文内で関数も定義できる
calcBMIs :: (RealFloat a) => [(a, a)] -> [a]
calcBMIs xs = [bmi w h | (w, h) <- xs]
 where bmi weight height = weight / (height ^ 2)

-- let in構文で同じようなことができる
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h = 
      let sideArea = 2 * pi * r * h
          topArea = pi * r ^ 2
      in sideArea + 2 * topArea

-- 違うのはlet in はifなどと同様にexpressionであること
-- expressionなら値を返すので下記のようなことができる
-- [let square x = x^2 in (square 5 , square 3)]
-- (let a = 100; b = 200; c = 300 in a*b*c, let foo="Hey "; bar = "there!" in foo ++ bar)
-- (let (a,b,c) = (1,2,3) in a+b+c)

calcBMIs' :: (RealFloat a) => [(a,a)] -> [a]
calcBMIs' xs = [bmi |(w,h) <- xs, let bmi = w / (h^2)]

calcBMIs'' :: (RealFloat a) => [(a,a)] -> [a]
calcBMIs'' xs = [bmi | (w,h) <- xs, let bmi = w / (h^2), bmi >= 20]

-- case文
-- 引数の値によるpattern matchingみたいなことができる
head' :: [a] -> a  
head' [] = error "No head for empty lists!"  
head' (x:_) = x  

head'' :: [a] -> a
head'' x = case x of [] -> error "No head for empty lists!"
                     (x:_) -> x

-- pattern matchingと異なり関数の中でも使える
describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of [] -> "empty!"
                                               [x] -> "a singleton list."
                                               xs -> " a longer list."