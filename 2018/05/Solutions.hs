module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Char
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

solution1 :: [Char] -> Int
solution1 list = length $ foldl reducer [] list

reducer :: [Char] -> Char -> [Char]
reducer [] c = [c]
reducer acc c
    | equals = tail acc
    | otherwise = c:acc
    where equals = (toUpper (head acc) == toUpper c) && ((head acc) /= c)

solution2 :: [Char] -> Int
solution2 code = head $ sort $ map (getSecondLength code) ['a'..'z']

getSecondLength :: [Char] -> Char -> Int
getSecondLength code char = solution1 $ filter ((/=char) . toLower) code

