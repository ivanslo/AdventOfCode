{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE BangPatterns        #-}


module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import Data.Text (Text)
import Data.Void

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = let
    parses = map (parseInput pRule) xs
    in operate parses

-- I just learned about this pattern looking at <https://github.com/dmjio/aoc2020/blob/main/8/Main.hs>
operate :: [(Operation, Int)] -> Int
operate insts = go [] 0 0
  where
    go idxs !idx !acc
      | elem idx idxs = acc -- ^ loop detected
      | otherwise =
          case insts !! idx of
            (OpNop, _)   ->
              go (idx : idxs) (idx + 1) acc
            (OpJmp, off) ->
              go (idx : idxs) (idx + off) acc
            (OpAcc, inc) ->
              go (idx : idxs) (idx + 1) (acc + inc) 

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = let
    parses = map (parseInput pRule) xs
    results = map (\nth -> tryOperate $ transformNthWith nth invertOp parses) [0,1..(length xs)]
    in fromJust . head $ filter (/= Nothing) results


transformNthWith :: Int -> (a->a) -> [a] -> [a]
transformNthWith _ _ [] = []
transformNthWith n fn (x:xs) 
    | n == 0 = (fn x):xs
    | otherwise = x:transformNthWith (n-1) fn xs

-- similar to `operate` but returns a Maybe
tryOperate :: [(Operation, Int)] -> Maybe Int
tryOperate insts = go [] 0 0
  where
    go idxs !idx !acc 
      | idx == l = Just acc
      | elem idx idxs = Nothing
      | otherwise =
          case insts !! idx of
            (OpNop, _)   ->
              go (idx : idxs) (idx + 1) acc
            (OpJmp, off) ->
              go (idx : idxs) (idx + off) acc
            (OpAcc, inc) ->
              go (idx : idxs) (idx + 1) (acc + inc) 
        where l = length insts


data Operation = OpAcc | OpJmp | OpNop deriving (Eq, Show)

invertOp :: (Operation, Int) -> (Operation, Int)
invertOp (OpAcc, x) = (OpAcc, x)
invertOp (OpJmp, x) = (OpNop, x)
invertOp (OpNop, x) = (OpJmp, x)

-- --------------------------------
-- Parsing 
type Parser = Parsec Void String

fromJust :: Maybe a -> a
fromJust (Just a) = a
fromJust Nothing = error "so bad"

parseInput :: Parsec e s c -> s -> c
parseInput rule = (\(Right x) -> x) . (parse rule "")

pOp:: Parser Operation
pOp= choice
    [ OpAcc <$ string "acc"
    , OpJmp <$ string "jmp"
    , OpNop <$ string "nop" ]

pVal :: Parser Int
pVal = do
    sign <- choice
        [ 1 <$ char '+'
        , -1 <$ char '-' ]
    val <- L.decimal
    return (sign * val)

pRule :: Parser (Operation, Int)
pRule = do
    op <- pOp
    val <- char ' ' *> pVal
    return (op, val)
    
