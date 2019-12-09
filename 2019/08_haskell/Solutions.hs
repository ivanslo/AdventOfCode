module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split -- requires `cabal install split --lib`

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

stripLine :: String -> String 
stripLine str = filter (/= '\n') str

parseInput :: [Char] -> [Int]
parseInput str = map (read . (:[])) $  stripLine str

countOf :: Int -> [Int] -> Int
countOf val l = length $ filter (==val) l

fewest0s :: [[Int]] -> [Int]
fewest0s = foldl1 (\l1 l2 -> if (countOf 0 l1) < (countOf 0 l2) then l1 else l2) 

operationMul :: [Int] -> Int
operationMul list = (countOf 1 list) * (countOf 2 list)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> Int -> Int -> Int
-- solution1 :: [Integer] -> Integer
solution1 strInput w h = trace'(show $ operationMul $ fewest0s $ chunksOf (w*h) $ parseInput strInput)  0


-- ----------------------------- 
-- SOLUTION 2
--
--
-- 0: black
-- 1: white
-- 2: transparent
solution2 :: String -> Int -> Int -> IO()
-- solution2 :: [Integer] -> Integer
-- solution2 strInput w h = trace'(show $ compareImages $ chunksOf (w*h) $ parseInput strInput) 0
-- solution2 strInput w h = trace'(show $ printClearer $ compareImages $ chunksOf (w*h) $ parseInput strInput) 0
-- solution2 strInput w h = trace'(concat $ map show $ compareImages $ chunksOf (w*h) $ parseInput strInput) 0
solution2 strInput w h = printOnScreen w $ compareImages $ chunksOf (w*h) $ parseInput strInput

printOnScreen :: Int -> [Int] -> IO ()
printOnScreen width list =  mapM_ (putStrLn) $ map printClearer $ chunksOf width list

printClearer :: [Int] -> [Char]
printClearer ss = map (\x -> if x == 1 then '0' else '.' ) ss

compareImages :: [[Int]] -> [Int]
compareImages lists = foldl1 (zipWith pixelComparisor) lists

pixelComparisor :: Int -> Int -> Int
pixelComparisor 0 _ = 0
pixelComparisor 1 _ = 1
pixelComparisor 2 x = x

