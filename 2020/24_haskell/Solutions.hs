{-# LANGUAGE OverloadedStrings #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Void
import Data.List
import Text.Regex.Posix
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Debug (dbg)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = let
    insts = map (p parseInstructions) xs
    points = sort $ map tileFor insts
    in length $ onlyOdds points

tileFor :: [Dir] -> (Int, Int)
tileFor ins = go (0,0) ins
    where
        go (x,y) [] = (x,y)
        go (x,y) (i:ins)
                | i == E  =  go (x+1,y  ) ins
                | i == W  =  go (x-1,y  ) ins
                | i == SE =  go (x  ,y+1) ins
                | i == SW =  go (x-1,y+1) ins
                | i == NE =  go (x+1,y-1) ins
                | i == NW =  go (x  ,y-1) ins
                | otherwise = error "whaatt"
            


onlyOdds :: [Tile] -> [Tile]
onlyOdds ps = concat  $ filter onlyOdd $ group ps
    where onlyOdd xs = (mod (length xs) 2) /= 0


-- ----------------------------- 
-- SOLUTION 2 -- INCOMPLETE
solution2 :: [String] -> Int
solution2 xs = let
    insts = map (p parseInstructions) xs
    points = sort $ map tileFor insts
    odds = onlyOdds points
    in 0


-- passDay :: [Tile] -> [Tile]
-- passDay tiles = let
--  -- get the universe (all the tiles from min-2 to max+2
--  - for each, check its neighbours and apply the rules
--  - return 

neighboursTo :: Tile -> [Tile]
neighboursTo (x,y) = [(x+1,y ),(x-1,y),(x,y+1),(x-1,y+1),(x+1,y-1),(x,y-1)]


-- ----------------------------- 
-- Parsing
type Parser = Parsec Void String
type Tile = (Int,Int)
data Dir = E | SE | SW | W | NE | NW deriving( Show, Eq)

getR (Right x) = x
getR (Left x) = error "Parsing Error"


p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")

parseInstructions:: Parser [Dir]
parseInstructions = do
    instrs <- many instructionP 
    return (instrs)

instructionP :: Parser Dir
instructionP = choice
            [ SE <$ "se"
            , SW <$ "sw"
            , E  <$ "e"
            , NE <$ "ne"
            , NW <$ "nw"
            , W <$ "w" ]
