module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = ones * threes
    where   ones = count (==1) diffs
            threes = count (==3) diffs
            diffs = differences $ sort (0:(map parseInt xs))

differences :: [Int] -> [Int]
differences (x:[]) = [3]
differences (x:y:xs) = (y-x): differences (y:xs)

count :: (Int -> Bool) -> [Int] -> Int
count fn xs = length $ filter fn xs

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = combinations  $ sort (0:(map parseInt xs))

combinations :: [Int] -> Int
combinations xs = snd $ head processed
    where processed = foldr (\x acc -> (x, howMany acc x):acc) [] xs

howMany :: [(Int, Int)] -> Int -> Int
howMany [] _ = 1
howMany lss limit = summy  $ takeWhile (\(x,n) -> (x-limit)<=3) lss
    where summy [] = 0
          summy (x:xs) = snd x + summy xs


-- parsing
parseInt :: String -> Int
parseInt x = read x :: Int
