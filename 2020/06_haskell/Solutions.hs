module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split (splitWhen)
import Data.List (intersect)
import Data.Set (toList, fromList)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = sum $ map length $ map uniques $ map concat $ groups xs


groups :: [String] -> [[String]]
groups = splitWhen (=="")

uniques :: Ord a => [a] -> [a]
-- transform the list to a set and to a list again.
uniques xs = toList $ fromList xs

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs =  sum $ map length $ map (foldl1 intersect) $ groups xs
