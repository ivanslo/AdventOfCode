module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

trace'' :: Show a => a  -> a
trace'' s = trace' (show s) s
-- trace'' s =  s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 list = maximum $ map getSeatId list

getSeatId :: String -> Int
getSeatId xs = 
    let seatId = 8 * getRow' (take 7 xs) + getColumn' (drop 7 xs)
    -- in trace' (xs ++ " - " ++ show seatId) seatId
    in seatId


getRow':: [Char] -> Int
getRow' xs = getRow xs 0 127

getColumn':: [Char] -> Int
getColumn' xs = getColumn xs 0 7

getRow :: [Char] -> Int -> Int -> Int
getRow ('F':[]) l h = l
getRow ('B':[]) l h = h
getRow (x:xs) l h
    | x == 'F' = getRow xs     l m
    | x == 'B' = getRow xs (m+1) h
    where m = div (l+h) 2

getColumn :: [Char] -> Int -> Int -> Int
getColumn ('R':[]) l h = h
getColumn ('L':[]) l h = l
getColumn (x:xs) l h 
    | x == 'L' = getColumn xs     l m
    | x == 'R' = getColumn xs (m+1) h
    where m = div (l+h) 2

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 list =
    let possibleSeats = pickSeats $ sort $ map getSeatId list
    in head possibleSeats  -- there should be only 1


pickSeats :: [Int] -> [Int]
pickSeats (a:[]) = []
pickSeats (a:b:xs)
    | diff == 2 = (a+1):pickSeats (b:xs)
    | otherwise = pickSeats (b:xs)
    where diff = b - a

