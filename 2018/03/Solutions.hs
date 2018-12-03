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
countPixels pixels = foldl (\acc x -> acc + (length $ filter (<0) x)) 0 pixels


solveIt :: [(Int, Int, Int, Int,Int)] -> [[Int]]
solveIt windows = foldl (\matrix win -> incrementFiles matrix win) (matrix1000) windows


matrix1000 = replicate 1000 $ replicate 1000 0
matrix10 = replicate 10 $ replicate 10 0


parseLine:: String -> [Int]
parseLine info =  map (toInt) $ filter ((>0) . length) $ splitOneOf ",:@#x" info
-- process code = trace'(" c: " ++ show (code)) 0

toInt :: String -> Int
toInt x = read x :: Int

toXYWH :: [Int] -> (Int, Int, Int, Int, Int)
toXYWH (n:x:y:w:h:xs) = (n, x,y,w,h)

incrementFiles :: [[Int]] -> (Int, Int,Int,Int,Int) -> [[Int]]
incrementFiles [] _ = []
incrementFiles (f:fs) (id,x,y,width,height)
    | y > 0      =  f:(incrementFiles fs (id,x,y-1,width, height))
    | height > 0 =  (incrementInterval f id x width):(incrementFiles fs (id, x,0,width,height-1))
    | otherwise  = f:fs

incrementInterval :: [Int] -> Int -> Int -> Int -> [Int]
incrementInterval [] _ _ _ = []
incrementInterval (x:xs) id p width
    | p > 0  = x:(incrementInterval xs id (p-1) (width))
    | width > 0 = (val):(incrementInterval xs id 0 (width-1))
    | otherwise = x:xs
    where val = if x == 0 then id else -1






-- solution 2

solution2 :: [String] -> Int
solution2 list = 
    let windows = map toXYWH $ map parseLine list
        solved = solveIt windows
        finalWindow = filter (\(i,x,y,w,h) -> (amountOf i solved) == w*h) windows
    in getId $ head finalWindow

amountOf :: Int -> [[Int]] -> Int
amountOf n matrix = sum $ map length $ map (filter (==n)) matrix
 

getId :: (Int, Int, Int, Int, Int) -> Int
getId (id,_,_,_,_) = id
