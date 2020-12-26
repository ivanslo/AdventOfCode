module Solutions(
    solution1,
    solution1',
    solution2
) where

import Debug.Trace
import Data.List
import Data.Char

import Control.Monad
import Control.Monad.ST
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as M

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> String
solution1 xs = let
    ns = map digitToInt xs
    ns' = pickFrom1 $ moveTimes 100 9 ns
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
-- solution without slicing arrays, but using the ST Monad
-- solution1' is the solution1 (returning the array) but using the new method

solution1' :: String -> Int -> Int -> String
solution1' xs times max = let 
    ns = map digitToInt xs
    ns' = [length(ns)+1..max]
    played = getOrdered . V.toList  $ makeVectorAndPlay (ns ++ ns') times
    in concat $ map show $ take (length ns-1) played

solution2 :: String -> Int -> Int -> String
solution2 xs times max = let 
    ns = map digitToInt xs
    ns' = [length(ns)+1..max]
    played = makeVectorAndPlay (ns ++ ns') times
    f1 = played V.! 1
    f2 = played V.! f1
    in show $ f1 * f2

getOrdered :: [Int] -> [Int]
getOrdered v = tail $ reverse $ foldr (\x acc -> (v!! head acc) : acc) [1] (reverse v)

pickPrev :: [Int] -> Int -> Int -> Int
pickPrev ls 0 maxEl = pickPrev ls maxEl maxEl
pickPrev ls n  maxEl
    | elem n ls = pickPrev ls (n-1) maxEl
    | otherwise = n

play v current = do
    s1 <- M.read v current
    s2 <- M.read v s1
    s3 <- M.read v s2
    s3_ <- M.read v s3

    let maxEl = (M.length v - 1)
    let idxN = (pickPrev [s1,s2,s3] (current-1) maxEl)
    after <- M.read v idxN
    M.write v current s3_
    M.write v idxN s1
    M.write v s3  after
    return s3_

makeVectorAndPlay :: [Int] -> Int -> V.Vector Int
makeVectorAndPlay nrs iters = runST $ do
    v <- M.new (length nrs + 1)
    zipWithM_ (M.write v) (0:nrs) (cycle nrs)
    foldM_ (const . play v) (head nrs) [1..iters] -- play n times
    v1 <-  V.freeze v
    return v1


