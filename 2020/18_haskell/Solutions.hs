{-# LANGUAGE OverloadedStrings #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Void
import Data.List
import qualified Data.Map as M
import Text.Regex.Posix
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import Text.Megaparsec.Debug (dbg)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = sum $ map (p (simpleExpressionP calcPileUp)) xs

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = sum $ map (p (simpleExpressionP calcPlusThenMult)) xs

-- ----------------------------- 
-- Parsing
type Expression = Int
type CalculateFn = Int -> [(Char, Int)] -> Int
type Parser = Parsec Void String

getR (Right x) = x
getR (Left x) = error "Parsing Error"

p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")



simpleExpressionP :: CalculateFn  -> Parser Int
simpleExpressionP ff = do
    initial <- L.decimal  <|> termP ff
    ops <-  many (modifP ff)
    return (ff initial ops)

termP :: CalculateFn -> Parser Int
termP ff = parens (simpleExpressionP ff) <|> (simpleExpressionP ff)


modifP :: CalculateFn -> Parser (Char, Int)
modifP ff = (,) <$> opP <*> (L.decimal <|> termP ff)

parens :: Parser a -> Parser a
parens = between (char '(') (char ')')

calcPileUp :: CalculateFn
calcPileUp a ops = foldl (\acc (op,b) -> calc op acc b) a ops

calcPlusThenMult :: CalculateFn
calcPlusThenMult base ((o,n):[]) = calc o base n
calcPlusThenMult base (('+',n):ops) =      calcPlusThenMult (base+n) ops
calcPlusThenMult base (('*',n):ops) =  base * calcPlusThenMult n ops

opP :: Parser Char
opP = " " *> ( char '+' <|> char '*' ) <* " "

calc :: Char -> Int -> Int -> Int
calc '+' a b = a + b
calc '*' a b = a * b
