module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- Functions

pointsFor :: Char -> Int
pointsFor ')' = 3
pointsFor ']' = 57
pointsFor '}' = 1197
pointsFor '>' = 25137
pointsFor _ = error "what"

parsingPoints :: Bool -> String -> Int
parsingPoints autoc ss = parse ss []
    where parse [] [] = 0
          parse [] s = if autoc then autocompleteEffort s else 0
          parse (s:ss) (tt)
            | s == '(' || s == '[' || s == '<' || s == '{' = parse ss (s:tt)
            | otherwise = parseCheck (s:ss) tt
                where   parseCheck (')':uu) ('(':vv) = parse uu vv
                        parseCheck (']':uu) ('[':vv) = parse uu vv
                        parseCheck ('}':uu) ('{':vv) = parse uu vv
                        parseCheck ('>':uu) ('<':vv) = parse uu vv
                        parseCheck (u:uu) _ = pointsFor u

syntaxErrorScore:: String -> Int
syntaxErrorScore = parsingPoints False

autocompleteScore :: String -> Int
autocompleteScore = parsingPoints True

autocompleteEffort :: String -> Int
autocompleteEffort stack = calc stack 0
    where calc [] acc = acc
          calc ('(':ss) acc = calc ss (acc*5+1)
          calc ('[':ss) acc = calc ss (acc*5+2)
          calc ('{':ss) acc = calc ss (acc*5+3)
          calc ('<':ss) acc = calc ss (acc*5+4)
          calc ss acc = error ("what is that " ++ ss)

middle :: (Ord a) =>  [a] -> a
middle xs = xs !! (div (length xs) 2)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = sum $ map syntaxErrorScore xs


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = middle $ sort $ map autocompleteScore $ filter (\x -> syntaxErrorScore x == 0) xs
