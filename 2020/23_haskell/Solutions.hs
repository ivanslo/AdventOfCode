module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List
import Data.Char

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> String
solution1 xs = let
    ns = map digitToInt xs
    ns' = pickFrom1 $ trace'' $ moveTimes 100 9 ns
    in concat $ map show ns'


pickFrom1 :: [Int] -> [Int]
pickFrom1 ns = take ((length ns)-1) $ tail $ dropWhile (/=1) (cycle ns)

moveTimes :: Int -> Int -> [Int] -> [Int]
moveTimes 0 largest xs = xs
moveTimes n largest xs = moveTimes (n-1) largest (move xs largest)

move :: [Int] -> Int -> [Int]
move (f:a:b:c:ns) largest = (locateIn ns (a:b:c:[]) (f-1) f largest) ++ [f]

locateIn :: [Int] -> [Int] -> Int -> Int -> Int -> [Int]
locateIn ls ins n1 taken biggest
    | n1 `elem` ls = s1 ++ [head s2] ++ ins ++ tail s2
    | otherwise = locateIn ls ins (n1') taken  biggest
            where   n1' = if n1 == 0 then biggest else n1-1
                    isPresent = not (n1 `elem` ins) &&  n1 /= taken
                    (s1, s2) = span (/=n1) ls

-- ----------------------------- 
-- SOLUTION 2
-- very ineficient... I copied the code from above so I can find a way to optimise it..
-- It doesn't even finishes... :(

solution2 :: String -> String
solution2 xs = let
    ns = map digitToInt xs
    ns' = trace'' $ pickTwoFrom1 $ moveTimes' 10000000 (ns ++ [10..1000000])
    in show $ product ns'

moveTimes' ::  Int -> [Int] -> [Int]
moveTimes' 0 xs = xs
moveTimes' n xs = moveTimes' (n-1) (move' xs)

move' :: [Int] ->  [Int]
move' (f:a:b:c:ns) = (locateIn' ns (a:b:c:[]) (f-1)) ++ [f]

locateIn' :: [Int] -> [Int] -> Int -> [Int]
locateIn' ls ins n1
    | n1 `elem` ls = s1 ++ [head s2] ++ ins ++ tail s2
    | otherwise = locateIn' ls ins (n1')
            where   n1' = if n1 == 0 then 1000000 else n1-1
                    (s1, s2) = span (/=n1) ls

pickTwoFrom1 :: [Int] -> [Int]
pickTwoFrom1 ns = take 2 $ tail $ dropWhile (/=1) (cycle ns)

