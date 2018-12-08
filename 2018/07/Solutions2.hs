
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
solution1 list = trace'( show $ solve1 $ rights $ map parseInput list) "e"


solve1 :: [Connection] -> String
solve1 conns =
    let nodes = getNodes conns
    in trace'(show nodes) ""

getNodes :: [Connection] -> String
getNodes conns = rmdups $ foldl (\acc x -> acc ++ [fst x] ++ [snd x]) "" conns

rmdups :: (Ord a) => [a] -> [a]
rmdups = map head . group . sort

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

solution2 :: [String] -> String
solution2 list = ""
