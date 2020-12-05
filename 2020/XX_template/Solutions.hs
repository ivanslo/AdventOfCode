module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
-- solution1 :: [Int] -> Int
-- solution1 :: [Integer] -> Integer
solution1 xs = 0


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
-- solution2 :: [Int] -> Int
-- solution2 :: [Integer] -> Integer
solution2 xs = 0
