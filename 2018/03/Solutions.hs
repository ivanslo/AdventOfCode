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

-- solution 1

solution1 :: [String] -> Int
solution1 list = countPixels $ solveIt  $ map toXYWH $ map parseLine list


countPixels :: [[Int]] -> Int
countPixels pixels = foldl (\acc x -> acc + (length $ filter (>1) x)) 0 pixels


solveIt :: [(Int, Int, Int, Int)] -> [[Int]]
solveIt windows = foldl (\matrix win -> incrementFiles matrix win) (matrix10by10) windows


matrix10by10 = replicate 1000 $ replicate 1000 0


parseLine:: String -> [Int]
parseLine info =  map (toInt) $ filter ((>0) . length) $ splitOneOf ",:@#x" info
-- process code = trace'(" c: " ++ show (code)) 0

toInt :: String -> Int
toInt x = read x :: Int

toXYWH :: [Int] -> (Int, Int, Int, Int)
toXYWH (n:x:y:w:h:xs) = (x,y,w,h)

incrementFiles :: [[Int]] -> (Int,Int,Int,Int) -> [[Int]]
incrementFiles [] _ = []
incrementFiles (f:fs) (x,y,width,height)
    | y > 0      =  f:(incrementFiles fs (x,y-1,width, height))
    | height > 0 =  (incrementInterval f x width):(incrementFiles fs (x,0,width,height-1))
    | otherwise  = f:fs

incrementInterval :: [Int] -> Int -> Int -> [Int]
incrementInterval [] _ _ = []
incrementInterval (x:xs) p width
    | p > 0  = x:(incrementInterval xs (p-1) (width))
    | width > 0 = (x+1):(incrementInterval xs 0 (width-1))
    | otherwise = x:xs






-- solution 2

solution2 :: [String] -> Int
solution2 list = 0
