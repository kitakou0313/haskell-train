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