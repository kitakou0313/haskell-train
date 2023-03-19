-- import時は文頭でimport構文を用いる
import Data.List

-- 関数を指定して読み込み
import Data.List (nub, sort)
-- 指定した関数を除外して読み込み
-- いくつかのmoduleで名前が重複してるときに便利
import Data.List hiding (nub)

-- 名前空間を参照する形でimportもできる
import qualified Data.Map
import qualified Data.Map as M

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub