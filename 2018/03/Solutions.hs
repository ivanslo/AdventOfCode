module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


solution1 :: [String] -> Int
solution1 list = trace("list: " ++ show list) 0

solution2 :: [String] -> Int
solution2 list = 0
