-- import時は文頭でimport構文を用いる
import Data.List

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub