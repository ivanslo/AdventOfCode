module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


-- solution 1
solution1 :: [String] -> Int
solution1 list =  solve list

reduceSomehow :: [Int] -> Int
reduceSomehow = sum 

solve :: [String] -> Int
solve list = foldr (*) 1 $ map length $ group . sort $  concat $ map countAppearances list 

countAppearances :: String -> [Int]
countAppearances code = filter (\x -> x == 2 || x == 3) $ map head $ group . sort $ map length $ group . sort $ code


-- solution 2
solution2 :: [String] -> String
solution2 list = head $ map charsInCommon $ filter (closeEnough 0) $ combineAll list list

combineAll :: [String] -> [String] -> [(String,String)]
combineAll a b = filter (\(x,y) -> x /= y) $ (,) <$> a <*> b

closeEnough :: Int -> (String, String) -> Bool
closeEnough diff ([], [])  = diff < 2
closeEnough diff ((a:as), (b:bs))
    | diff > 1  = False
    | a == b    = closeEnough diff (as,bs)
    | otherwise = closeEnough (diff+1) (as,bs) 

charsInCommon :: (String, String) -> String
charsInCommon ([], []) = ""
charsInCommon (a:as, b:bs)
    | b == a    = a:(charsInCommon (as, bs))
    | otherwise = charsInCommon (as, bs)

