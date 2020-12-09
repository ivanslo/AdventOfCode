{-# LANGUAGE OverloadedStrings   #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Megaparsec
import Text.Megaparsec.Char
import qualified Text.Megaparsec.Char.Lexer as L
import Text.Megaparsec.Debug    (dbg)
import Data.Text (Text)
import Data.Void
import qualified Data.Map as M


-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s



-- -----------------------------
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = howManyContain "shiny gold" dict
    where dict = M.fromList $ map (parseInput parseLine) xs

-- this is ineficient, since I might query `isInside` multiple times for the same key
-- but well... 
howManyContain :: String -> M.Map String [(String, Int)] -> Int
howManyContain key m = length $ filter (==True) $ map (\k -> isInside (m M.! k)) (M.keys m)
    where
        isInside :: [(String, Int)] -> Bool
        isInside [] = False
        isInside xs
            | any (\(bn, q) -> bn == key) xs    = True
            | otherwise = any (==True) $ map (\(k,q) -> isInside (m M.! k)) xs

-- -----------------------------
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = howManyBagsWithin "shiny gold" dict 
    where dict = M.fromList $ map (parseInput parseLine) xs

howManyBagsWithin :: String ->  M.Map String [(String,Int)] -> Int
howManyBagsWithin key m = sum $ map ss (m M.! key)
    where ss (bag,nr) = nr + nr * (howManyBagsWithin bag m)

-- -----------------------------
-- Parsing

type Parser = Parsec Void String

parseInput :: Parsec e s c -> s -> c
parseInput rule = (getR) . (parse rule "")

getR (Right x) = x
getR (Left x) = error "Parsing Error"

parseLine :: Parser (String, [(String, Int)])
parseLine = do
    b <- bag
    _ <- string " contain "
    rest <- [] <$ "no other bags" <|> bagn `sepBy1` ", "
    return (b, rest)

bag :: Parser String
bag = some letterChar <> " " <> some letterChar <* " bag" <* optional "s"

bagn :: Parser (String, Int)
bagn = (\a b -> (b,a)) <$> L.decimal <* " " <*> bag


