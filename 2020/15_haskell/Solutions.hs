module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List
import Data.List.Split
import qualified Data.Map as M

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> Int
solution1 xs = solveFor 2020 nns
    where nns = reverse $ map asInt (splitOn "," xs)

-- ----------------------------- 
-- SOLUTION 2
solution2 :: String -> Int
solution2 xs = solveFor 30000000 nns
    where nns = reverse $ map asInt (splitOn "," xs)



solveFor :: Int -> [Int] -> Int
solveFor turn (n:ns) =  let
    nsL = length ns
    mmm = M.fromList $ zip ns [nsL,nsL-1..]
    in findNInTurn' n mmm turn

-- find the Nr in the Turn
findNInTurn' :: Int ->  M.Map Int Int -> Int -> Int
findNInTurn' last mapall limit = go last mapall (length mapall +1)
    where 
        go :: Int -> M.Map Int Int -> Int -> Int
        go x m turn
            | turn == limit = x
            | found == True = go (turn-foundIdx) (M.insert x turn m) (turn+1)
            | found == False = go 0 (M.insert x turn m) (turn+1)
            where
                (found, foundIdx) = case M.lookup x m of
                                        (Just n) -> (True, n)
                                        Nothing -> (False, 0)



-- -----------------------------
-- Parsing

asInt :: String -> Int
asInt s = read s :: Int
