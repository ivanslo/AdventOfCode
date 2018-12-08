
module Solutions2(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Char
import Data.Either
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a
type Connection = (Char, Char)

-- SOLUTION 1

solution1 :: [String] -> String
-- solution1 list = concat $ map rmdups $ makeLists [] $ rights $ map parseInput list
solution1 list = trace'( show $ map rmdups $ makeLists [] $ rights $ map parseInput list) "e"

parseEdge :: Parsec String () (Char, Char)
parseEdge = do
  _ <- string "Step "
  x <- anyChar
  _ <- string " must be finished before step "
  y <- anyChar
  string " can begin."
  spaces
  return (x, y)

parseInput :: String -> Either ParseError (Char, Char)
parseInput = parse parseEdge ""

makeLists :: [[Char]] -> [Connection] -> [[Char]]
makeLists [] (c:cs) = 
        let f = fst c
            s = snd c
        in makeLists [[f], [s]] (cs)
makeLists table [] = table
makeLists table (c:cs)
    | isSecond   = makeLists (addWithSecond f s table) cs
    | isFirst    = makeLists (addWithFirst  f s table) cs
    -- otherwise reinsert the thing at the end
    | otherwise  = makeLists table (cs ++ [c])
    where   s = snd c
            f = fst c
            isSecond = present table s
            isFirst = present table f
    
-- cleanBack :: [String] -> [String]
-- cleanBack ls =  foldr1 (\x acc -> (filterChars x acc)) ls


filterChars :: String -> String -> String
filterChars word flt = filter (\x -> not (x `elem` flt)) word
-- (filter (\x -> not ( x `elem` "NOELIA")) "IVAN" ) ++"NOELIA"
    -- in trace'("isSecond? : " ++ (show $ isSecond) ++ (show $ isFirst)) table

rmdups :: (Ord a) => [a] -> [a]
rmdups = map head . group . sort

addWithSecond :: Char -> Char -> [[Char]] -> [[Char]]
-- addWithSecond from to table = trace'("second - "++ (show $ [from]++"->"++[to])) table
addWithSecond a b (t:t2:ts)
        | b `elem` t2 = (addInLast a t):t2:ts
        | otherwise = t:(addWithSecond a b (t2:ts))


cleanThis :: Char -> [Char] -> [Char]
cleanThis c str = filter (/=c) str

addInLast :: Char -> [Char] -> [Char]
addInLast c str = (c:str)


addWithFirst :: Char -> Char -> [[Char]] -> [[Char]]
addWithFirst a b (t:ts)
        | a `elem` t = t:(addRightNext b ts)
        | otherwise  = t:(addWithFirst a b ts)

addRightNext :: Char -> [[Char]] -> [[Char]]
addRightNext c [] = [[c]]
addRightNext c (t:ts) = (t++[c]):ts

present :: [[Char]] -> Char -> Bool
present ls c = (sum $ map length $ map (filter (==c)) ls) > 0

solution2 :: [String] -> String
solution2 list = ""
