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

-- toArray :: Int -> [Int]
-- toArray = map (read . (:[])) . show

toArray' :: Int -> [Int]
toArray' 0 = []
toArray' x =  toArray' (x `div` 10) ++ [ x `mod` 10]


isAscendent :: [Int] -> Bool
isAscendent xs = fst $ foldl (\(v, a) b -> (v && a <= b, b)) (True,0) xs

isRepeated :: [Int] -> Bool
isRepeated x = any ((>1) . length) $ group x

isRepeatedOnlyTow :: [Int] -> Bool
isRepeatedOnlyTow x = any ((==2) . length) $ group x

isValid :: Int -> Bool
isValid nr = (isAscendent . toArray') nr && (isRepeated . toArray') nr

isValid' :: Int -> Bool
isValid' nr = (isAscendent . toArray') nr && (isRepeatedOnlyTow . toArray') nr

-- ----------------------------- 
-- SOLUTION 1
solution1 :: Int -> Int -> Int
solution1 a b = length $ filter (==True) (fmap isValid [a..b])

-- ----------------------------- 
-- SOLUTION 2
solution2 :: Int -> Int -> Int
solution2 a b = length $ filter (==True) (fmap isValid' [a..b])
