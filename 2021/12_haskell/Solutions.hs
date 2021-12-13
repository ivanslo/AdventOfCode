module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.Map as M
import Data.List.Split
import Data.Char
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- functions

parseInput :: String -> [(String, [String])]
parseInput ss = 
    let [a,b] = splitOn "-" ss
    in [(a,[b]),(b,[a])]

makeMap :: [String] -> M.Map String [String]
makeMap ss = M.fromListWith (++) $ concat $ map parseInput ss

lowercase :: String -> Bool
lowercase ss = and $ map isLower ss

traverseAll :: M.Map String [String] -> [Int]
traverseAll mm = go "start" []
    where go key visited
            | key == "end" = [1]
            | lowercase key && elem key visited = [0]
            | otherwise = concat $ map (\k -> go k (key:visited)) (mm M.! key)

countIf :: Eq a => a -> [a] -> Int
countIf a aa = length $ filter (==a) aa

lowercaseGroupsOverLimit :: [String] -> Int
lowercaseGroupsOverLimit ss = length $ filter (>1) $ map length $ group $ sort $ filter lowercase ss

traverseAll' :: M.Map String [String] -> [Int]
traverseAll' mm = go "start" []
    where go key visited
            | key == "end" = [1] 
            | key == "start" && length visited > 0 = [0]
            | lowercase key && countIf key visited == 2 = [0]
            | lowercaseGroupsOverLimit (key:visited) > 1 = [0]
            | otherwise = concat $ map (\k -> go k (key:visited)) (mm M.! key)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = sum $ traverseAll $ makeMap xs


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = sum $ traverseAll' $ makeMap xs
