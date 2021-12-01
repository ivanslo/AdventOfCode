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
solution1 :: [Int] -> Int
solution1 xs = countIncreases xs

countIncreases :: [Int] -> Int
countIncreases xs = length $ filter (==True) $ zipWith (<) xs (drop 1 xs)

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [Int] -> Int
solution2 xs = let
    list = map (\(x,y,z) -> x+y+z) $ triplets xs
    in countIncreases list

triplets :: [Int] -> [(Int, Int, Int)]
triplets xs = zip3 xs (drop 1 xs) (drop 2 xs)
