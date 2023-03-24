data Person = Person String String Int Float String String deriving(Show)

person1 = Person "Buddy" "Finklestein" 43 182.2 "562-2928" "Chocolate"

firstName :: Person -> String
firstName (Person firstName _ _ _ _ _) = firstName

lastName :: Person -> String
lastName (Person _ lastName _ _ _ _) = lastName

age :: Person -> Int
age (Person _ _ age _ _ _) = age

height :: Person -> Float
height (Person _ _ _ height _ _ ) = height

phoneNumber :: Person -> String
phoneNumber (Person _ _ _ _ number _) = number

flavor :: Person -> String
flavor (Person _ _ _ _ _ flavor) = flavor

-- Record syntax　Value内の特定の値の抽出はめんどくさい
data Person2 = Person2 {
    firstName2::String,
    lastName2::String,
    age2::Int,
    height2::Float,
    phoneNumber2::String,
    flavor2:: String
}deriving (Show)
-- GoのStructみたいに書ける

-- 自動的に各fieldを抽出する関数を定義してくれてる
person2 = Person2 "Buddy" "Finklestein" 43 182.2 "562-2928" "Chocolate"
firstNamePerson2 = firstName2 person2