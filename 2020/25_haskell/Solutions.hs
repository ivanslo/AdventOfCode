{-# LANGUAGE BangPatterns        #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = let
    (ck:dk:[]) = map asInt xs
    cls = loopSize ck
    in transformN dk cls

loopSize :: Int -> Int
loopSize pk = go 0 7
    where go i !nr
            | nr == pk = i+1
            | otherwise = go (i+1) (nr')
                where   nr' = mod (nr * 7) 20201227

transformN :: Int -> Int -> Int
transformN subject loopSize = go loopSize subject
    where go ls nr
            | ls == 1 = nr
            | otherwise = go (ls-1) (nr')
                    where   nr' = mod (nr * subject) 20201227

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = 0



-- ----------------------------- 
-- Parsing
asInt :: String -> Int
asInt s = read s :: Int
