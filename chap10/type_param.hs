-- Type ConstructorとType parameters

-- Value constructorと同様にType constructorも存在する
-- Type paramterとして型を受け取って型を返す

-- 以下ではMaybeはType constructor、
-- aがType parameterと呼ぶ
data Maybe a = Nothing | Just a
-- 型がNothingではないなら、何らかの型を持つ
-- Maybe Int, Maybe floatなど
-- Maybe自体の型を持つ値はない（Type constructorなので）

