module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Control.Applicative


-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [Integer] -> Integer
solution1 lis = (\(x,s) -> x * s) $ (goodNumbers . combinations) lis

goodNumbers :: [(Integer, Integer)] -> (Integer, Integer)
goodNumbers xs = head $ filter (\(a,b) -> a + b == 2020 ) xs

combinations:: [Integer] -> [(Integer, Integer)]
combinations list = (,) <$> list <*> list

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [Integer] -> Integer
solution2 lis = (\(x,y,s) -> x * s * y) $ (goodNumbers' . combinations') lis

goodNumbers' :: [(Integer, Integer, Integer)] -> (Integer, Integer, Integer)
goodNumbers' xs = head $ filter (\(a,b,c) -> a + b + c == 2020 ) xs

combinations':: [Integer] -> [(Integer, Integer, Integer)]
combinations' list = [(a,b,c) | a<-list, b<-list, c<-list]
