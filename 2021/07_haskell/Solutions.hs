module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- functions
toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

parseInput :: String -> [Int]
parseInput xs = map toInt $ splitOn "," xs

fuelAt :: [Int] -> Int -> Int
fuelAt list pos = sum $ map (\x -> abs (x-pos)) list 

sumatoriesTo :: Int -> Int
sumatoriesTo n = div (n * (n+1)) 2

fuelAt' :: [Int] -> Int -> Int
fuelAt' list pos = sum $ map sumatoriesTo $ map (\x -> abs (x-pos)) list 

-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> Int
solution1 xs = 
    let nns = parseInput xs
        fuels = map (fuelAt nns) [(minimum nns)..(maximum nns)]
    in minimum  fuels

-- ----------------------------- 
-- SOLUTION 2
solution2 :: String -> Int
solution2 xs = 
    let nns = parseInput xs
        fuels = map (fuelAt' nns) [(minimum nns)..(maximum nns)]
    in minimum  fuels
