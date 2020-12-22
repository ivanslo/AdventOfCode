{-# LANGUAGE OverloadedStrings #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Void
import Data.List.Split (splitWhen)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = total
    where
        (xs1:xs2:[]) =  splitWhen (=="") xs
        c1 = map asInt (tail xs1)
        c2 = map asInt (tail xs2)
        total = play c1 c2
    

play :: [Int] -> [Int] -> Int
play [] c2 = calcPoints c2
play c1 [] = calcPoints c1
play c1 c2 = play c1' c2'
    where
        zs = zipWith (,) c1 c2
        c1' = drop (length zs) c1 ++ (concat $ map (\(a,b) -> [a,b]) $ (filter (\(a,b) -> a > b) zs))
        c2' = drop (length zs) c2 ++ (concat $ map (\(a,b) -> [b,a]) $ (filter (\(a,b) -> a < b) zs))


calcPoints :: [Int] -> Int
calcPoints nns = sum $ zipWith (*) nns [lnns,lnns-1..1]
    where lnns = length nns

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
-- solution2 :: [Int] -> Int
-- solution2 :: [Integer] -> Integer
solution2 xs = 0



-- ----------------------------- 
-- Parsing

asInt :: String -> Int
asInt n = read n :: Int
