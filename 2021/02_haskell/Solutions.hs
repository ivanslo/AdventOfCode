module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split
import Text.Regex.Posix

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------
-- functions
-- processMovement :: (dir, value) -> x,y -> x,y
processMovement :: (String, Int) -> (Int, Int) -> (Int, Int)
processMovement (dir, val) (x, y)
    | dir == "forward" = (x+val, y)
    | dir == "up"      = (x    , y-val)
    | dir == "down"    = (x    , y+val)
    | otherwise = error "direction not recognised"

processMovement' :: (String, Int) -> (Int, Int, Int) -> (Int, Int, Int)
processMovement' (dir, val) (x, y, a)
    | dir == "forward" = (x+val, y+a*val,a)
    | dir == "up"      = (x    , y, a-val)
    | dir == "down"    = (x    , y, a+val)
    | otherwise = error "direction not recognised"

parseInput :: String -> (String, Int)
parseInput s = 
    let (_, _, _,(dir:valS:xs)) = s =~ "(.*) (.*)" :: (String, String, String, [String])
        val = read valS :: Int 
    in (dir, val)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = 
    let parsed = map parseInput xs
        (x, y) = foldr processMovement (0,0) parsed
    in x * y

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs =
    let parsed = map parseInput xs
        (x, y, a) = foldl (\acc x -> processMovement' x acc) (0,0,0) parsed
    in x * y
