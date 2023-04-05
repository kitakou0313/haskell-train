import qualified Data.Map as Map

-- Type ConstructorとType parameters

-- Value constructorと同様にType constructorも存在する
-- Type paramterとして型を受け取って型を返す

-- 以下ではMaybeはType constructor、
-- aがType parameterと呼ぶ
data Maybe a = Nothing2 | Just2 a
-- 型がNothingではないなら、何らかの型を持つ
-- Maybe Int, Maybe floatなど
-- Maybe自体の型を持つ値はない（Type constructorなので）
-- Maybe Intを引数とする関数にMaybe a型を渡すことも可能
-- 上の定義ではNothigもMaybe aに含まれるため，Maybe Int型としてNothingを渡せる
-- aが定まった時にMaybe Int = Nothing | Just Intになるため，定義的には確かにそう 

-- 型定義で具体的な型を指定
-- pattern matchでその型を持つ変数として受け取る
data TestType a = TestType a
testFunc ::  TestType String -> String
testFunc (TestType var) = var 

-- 型paramを持つかつ複数のValue Constructorを持つ場合
-- pattern match系はValue constructorを元に行うので関数の型定義で型paramを指定，Value constructorはそれに従ってpattern matchをやるイメージ
data Maybe5 a = Nothing5 | Just5 a
testFunc2 :: Maybe5 String -> String
testFunc2 a = 
    case a of Nothing5 -> "Error!"
              (Just5 a) -> a


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

-- ある振る舞いをするのに型が影響しないときなどに使用する
-- ex. list...格納する値はなんでもよい

-- Map型にも使われている
-- Map k, v ... kはOrdの制約あり

-- 注意:type classによる制約をdata declarationsに加えるべきではない
-- その型に関連する全ての関数の定義にtype class制約を書く必要がでるため

-- 制約を仮定したい関数の定義で書くのが良さそう
-- 制約に関する知識が型の定義に集約されないのは不便そう

-- Vectorの定義の例

data Vector a = Vector a a a deriving (Show)
vplus :: (Num t) => Vector t -> Vector t -> Vector t
vplus (Vector i j k) (Vector x y z) = Vector (i+x) (j+y) (k+x)

-- Value ConstructorとType Constructorの違い
-- data構文の左辺がType constructor, 右辺がValue Constructor

-- Type class...OOPのinterfaceみたいなもの
-- 含まれる型はType instanceとよぶ
-- 関数型プログラミングではdataの定義->後でどのType classに入れるか決める

-- Eq, Ord, Enum, Bounded, Show, Readはderiving構文で自動的にtype classのinstaceとできる
data Person3 = Person3 {
    firstName3 :: String,
    lastName :: String,
    age3 :: Int
} deriving (Eq, Show, Read)

-- Ord type classについて
-- 異なるValue Constrctorで得られた値を比較する場合，最初に定義された方が小さい扱いになる
data Bool3 = False3 | True3 deriving (Eq, Ord)
-- False3 < True3はTrueになる

-- Ordをderiveする場合はEq Typeclassをderiveする必要があるっぽい
-- deriveing (Eq, Ord)にしないとエラーになる
-- Mondayなどはnullaly（フィールドをもたない）なValue constructor
data Day = Monday | Tuesday | WednesDay | Friday | Saturaday | Sunday deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- type synonimus
-- type構文で型に別名をつけられる
type String2 = [Char]

-- 可読性の向上に使用できる
phoneBook :: [(String, String)]
phoneBook = 
    [("betty", "555-2938"),
    ("bonnie", "452-2928")]

type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]
phoneBook2 :: PhoneBook
phoneBook2 = [
    ("betty","555-2938")]

-- type paramの使用も可能
type AssocList k v = [(k,v)]
-- 関数と同じくparticial applyも可能
type IntMap v = Map.Map Int v
type IntMap2 = Map.Map Int

-- 便利な型としてEither型がある
data Either2 a b = Left2 a | Right2 b deriving (Eq, Ord, Read, Show)
-- Left aのValue constructorならLeft a，Right bならRight bだが，
-- 両方ともEither a b型として扱える
-- :t Right 'a'
-- Either a Char
-- :t Left True
-- Either Bool b

-- 複数の理由でエラーを返すことがある関数に用いると便利
-- Leftをエラー用，Rightが正しい値用
data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookUp :: Int -> LockerMap -> Either2 String Code
lockerLookUp lockerNumber map = 
    case Map.lookup lockerNumber map of
        Nothing -> Left2 $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
        Just (state, code) -> if state /= Taken
                                then Right2 code
                                else Left2 $ "Locker " ++ show lockerNumber ++ " is already taken!"

lockers :: LockerMap
lockers = Map.fromList 
    [(100, (Taken, "AD39I"))
    ,(101, (Free, "JAHH3I"))
    ]
-- 3通りの出力が見れる

-- ghci> lockerLookUp 101 lockers 
-- Right2 "JAHH3I"
-- ghci> lockerLookUp 100 lockers 
-- Left2 "Locker 100 is already taken!"
-- ghci> lockerLookUp 103 lockers 
-- Left2 "Locker number 103 doesn't exist!"