-- Type ConstructorとType parameters

-- Value constructorと同様にType constructorも存在する
-- Type paramterとして型を受け取って型を返す

-- 以下ではMaybeはType constructor、
-- aがType parameterと呼ぶ
data Maybe a = Nothing | Just a
-- 型がNothingではないなら、何らかの型を持つ
-- Maybe Int, Maybe floatなど
-- Maybe自体の型を持つ値はない（Type constructorなので）
-- Maybe Intを引数とする関数にMaybe a型を渡すことも可能
-- 上の定義ではNothigもMaybe aに含まれるため，Maybe Int型としてNothingを渡せる
-- aが定まった時にMaybe Int = Nothing | Just Intになるため，定義的には確かにそう 

-- Carをtype paramを使って定義
data Car2 a b c = Car2 {
    company2 :: a,
    model2 :: b,
    year2 :: c
} deriving (Show)

-- a,b,cにはどんな型を入れてもいいのか？
-- 定義した関数によって制約される
-- 下の例ではcの方はShow型，a,bはStringの型である必要がある
tellCar2 :: Show a => Car2 [Char] [Char] a -> [Char]
tellCar2 (Car2 {company2=c, model2=m, year2=y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y