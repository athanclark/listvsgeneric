module Competition.List where

import Data.IntMap as IntMap


listToIntMap :: [a] -> IntMap a
listToIntMap xs = IntMap.fromList $ [0..] `zip` xs
