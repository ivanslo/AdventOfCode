module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split      (splitWhen)
import Data.List            (intersect, nub)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = sum $ map (length . nub . concat) $ groups xs

groups :: [String] -> [[String]]
groups = splitWhen (=="")

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs =  sum $ map (length . foldl1 intersect) $ groups xs
