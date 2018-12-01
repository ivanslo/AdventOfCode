module SolutionsImproved(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.Set as S
import Data.Set (Set)
-- import qualified Data.IntSet as IntSet


-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


solution1 :: [Integer] -> Integer
solution1 = sum 

solution2 :: [Integer] -> Integer
solution2 list = returnAtFirstDuplicated (S.fromList []) 0 (cycle list)

returnAtFirstDuplicated :: Set Integer -> Integer -> [Integer] -> Integer
returnAtFirstDuplicated set last (x:xs)
        | S.member last set = last
        | otherwise     = returnAtFirstDuplicated (S.insert last set) last' xs
        where last' = last + x
