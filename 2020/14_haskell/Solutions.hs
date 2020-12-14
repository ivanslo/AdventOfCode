{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BangPatterns #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Bits

import Data.Word
import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import qualified Data.Map as M
import qualified Data.List as LI


-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


setBits :: Int -> [Int] -> Int
setBits initial bits = foldr (\x acc -> setBit acc x) initial bits

clearBits:: Int -> [Int] -> Int
clearBits initial bits = foldr (\x acc -> clearBit acc x) initial bits

-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> Int
solution1 xs = M.foldr (+) 0 $ M.fromList memories
    where   progs = p parseAll xs
            memories = concat $ map computePr progs

computePr :: Program -> [Memory]
computePr (bt1, bt0, _, inss) = map (\(mem, val) -> (mem, maskNrBits val bt1 bt0)) inss

maskNrBits :: Int -> BitsPos -> BitsPos -> Int
maskNrBits n b1 b0 = clearBits (setBits n b1) b0


-- ----------------------------- 
-- SOLUTION 2
solution2 :: String -> Int
solution2 xs = M.foldr (+) 0 $ M.fromList memories
    where   progs = p parseAll xs
            memories = concat $map computePr' progs

computePr' :: Program -> [Memory]
computePr' (bt1, bt0, btX, inss) = concat $ foldr (\(mem, val) acc -> (manyMemSets mem val):acc) [] inss
    where manyMemSets mem val = let
                mem'' = clearBits (setBits mem bt1) (btX)
                mems = map (setBits mem'') (LI.subsequences btX)
                in  map (\me -> (me, val)) mems

-- ----------------------------- 
-- PARSING
type Memory = (Int, Int)
type Program = (BitsPos , BitsPos, BitsPos, [Instr])
type Instr = (MemAddress, Value)
type BitsPos = [Int]
type MemAddress = Int
type Value = Int

type Parser = Parsec Void String

bitsPosWith :: String -> Char -> BitsPos
bitsPosWith bitStr c = map fst $ filter (\x -> snd x == c) $ zip [35,34..0] bitStr

getR (Right x) = x
getR (Left x) = error "Parsing Error"

p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")

parseAll :: Parser [Program]
parseAll = do
    prog <- many programP
    return prog

programP :: Parser Program
programP = do 
    bits <- "mask = " *> many (char 'X' <|> char '1' <|> char '0') <* newline
    instr <- many instrP
    return (bitsPosWith bits '1', bitsPosWith bits '0', bitsPosWith bits 'X', instr)

instrP :: Parser Instr
instrP = do
    add <- "mem[" *> L.decimal <* "] = "
    val <- L.decimal  <* newline
    return (add :: Int, val :: Int)


asInt :: String -> Int
asInt x = read x :: Int
