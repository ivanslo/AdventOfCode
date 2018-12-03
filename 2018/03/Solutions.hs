module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


solution1 :: [String] -> Int
solution1 list = sum $ map parseLine list 

parseLine:: String -> Int
parseLine info = trace'(" window: " ++ show (map (toInt) $ filter ((>0) . length) $ splitOneOf ",:@#x" info)) 0
-- process code = trace'(" c: " ++ show (code)) 0

toInt :: String -> Int
toInt x = read x :: Int

solution2 :: [String] -> Int
solution2 list = 0
