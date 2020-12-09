module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.Set as S
import qualified Data.List as L

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int -> Int
solution1 xs pr = firstInvalid (map parseInt xs) pr


firstInvalid :: [Int] -> Int -> Int
firstInvalid xs preamble =  go (take preamble xs) (drop preamble xs)
    where 
        go _ [] = error "non invalid"
        go pre (po:pos) = case twoMakesN pre po of
                True -> go ((tail pre)++[po]) pos
                False -> po

twoMakesN :: [Int] -> Int -> Bool
twoMakesN ss n = any (\s -> (n-s) `elem` ss) ss

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int -> Int
solution2 xs preamble = let
        xsInt = map parseInt xs
        target = firstInvalid xsInt preamble
        (from, to) = rangeToSum target $ scanl1 (+) xsInt
        inRange = take (to-from) (drop from xsInt) 
    in minimum inRange + maximum inRange

rangeToSum :: Int -> [Int] -> (Int, Int)
rangeToSum target xs = go [] xs
    where
        go seen [] = error "not found"
        go seen (x:xs)
            | found > -1    = (found, length seen)
            | otherwise     = go (seen ++ [x]) xs
            where found = case L.elemIndex (x-target) seen of
                                (Just x) -> x
                                Nothing -> -1

--------------------------------
-- Parsing
parseInt :: String -> Int
parseInt s = read s :: Int
