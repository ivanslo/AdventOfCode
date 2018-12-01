module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


solution1 :: [Integer] -> Integer
solution1 list = foldr (+) 0 list

solution2 :: [Integer] -> Integer
solution2 list = trace'("List: "++ show (take 10 $ cycle list)) returnAtFirstDuplicated [0] (cycle list)

returnAtFirstDuplicated :: [Integer] -> [Integer] -> Integer
returnAtFirstDuplicated [] (x:xs) = returnAtFirstDuplicated [x] xs
returnAtFirstDuplicated acc (x:xs)
        | elem x' acc = trace'("x' = "++ show x' ++ " -- list: " ++ show acc)  x'
        | otherwise = trace'("recursing with " ++ show (x':acc)) returnAtFirstDuplicated (x':acc) xs
        where x' = (head acc) + x
