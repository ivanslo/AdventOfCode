module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.List.Split as LS
-- import qualified Data.Vector as V

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s
-- trace'' s = s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = length $ filter (=='#') $ untilNoChange board rows cols newBoard'
    where
        rows = length xs
        cols = length (xs !! 0)
        board = flattenBoard xs

flattenBoard :: [[Char]] -> [Char]
flattenBoard b = concat b


untilNoChange :: [Char] -> Int -> Int -> ([Char] -> Int -> Int -> [Char]) -> [Char]
untilNoChange b rows cols fn = go b 0
    where 
        go curr count
            | count > 1000 = trace'' curr  -- ^ cut the execution just because...
            | next == curr = trace'(show count) curr
            | otherwise = go next (count+1)
            where next = fn curr rows cols

newBoard' :: [Char] -> Int -> Int -> [Char]
newBoard' board rows cols = foldr (\x acc -> (charAt x):acc) [] [0..((rows*cols)-1)]
    where 
        charAt n = case (board !! n) of
                    '.' -> '.'
                    '#' -> case occuppiedAdj n >= 4 of
                            True -> 'L'
                            _ -> '#'
                    'L' -> case occuppiedAdj n of
                            0 -> '#'
                            _ -> 'L'
        occuppiedAdj idx = length $ adjacents board rows cols r c 
            where   r = div idx cols
                    c = mod idx cols

adjacents :: [Char] -> Int -> Int -> Int -> Int -> [Char]
adjacents board rows cols r c = filter (=='#') $ adjList
    where 
        idcs = [(r-1,c-1),(r-1,c),(r-1,c+1),(r,c-1),(r,c+1),(r+1,c-1),(r+1,c),(r+1,c+1)]
        goodIdxs = filter (\(r,c) -> valid r rows && valid c cols) idcs
        adjList = foldr (\(r,c) acc -> (board !! (r*cols+c)):acc) [] goodIdxs


newBoard'' :: [Char] -> Int -> Int -> [Char]
newBoard'' board rows cols = foldr (\x acc -> (charAt x):acc) [] [0..((rows*cols)-1)]
    where 
        charAt n = case (board !! n) of
                    '.' -> '.'
                    '#' -> case occuppiedVisible n >= 5 of
                            True -> 'L'
                            _ -> '#'
                    'L' -> case occuppiedVisible n of
                            0 -> '#'
                            _ -> 'L'
        occuppiedVisible idx = length $ filter (=='#') $ visibles board rows cols r c 
            where   r = div idx cols
                    c = mod idx cols

dirs = [(-1,-1),(-1,0),(-1, 1),(0,-1),(0, 1),( 1,-1),( 1,0),( 1, 1)]

visibles :: [Char] -> Int -> Int -> Int -> Int -> [Char]
visibles board rows cols r c = map findInDir dirs
    where 
        findInDir (dr,dc) = go (r+dr) (c+dc) dr dc
        go r' c' dr dc
            | not (valid r' rows) || not ( valid c' cols) = '.'
            | elem == 'L' = 'L'
            | elem == '#' = '#'
            | otherwise = go (r'+dr) (c'+dc) dr dc
            where elem = board !! (r'*cols+c')

valid :: Int -> Int -> Bool
valid n limit = n >= 0 && n < limit
-- ----------------------------- 
-- SOLUTION 2

solution2 :: [String] -> Int
solution2 xs = length $ filter (=='#') $ untilNoChange board rows cols newBoard''
    where
        rows = length xs
        cols = length (xs !! 0)
        board = flattenBoard xs

