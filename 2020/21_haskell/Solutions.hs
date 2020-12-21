{-# LANGUAGE OverloadedStrings #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.List.Split as DLS
import Data.Void
import Data.Set as S
import Data.List as DL
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
solution1 xs = let
    rec = DL.map (p parseReceipe) xs
    mms = foldr1 (M.unionWith S.intersection)  $ DL.map (toAllergDict) rec
    bannedIngr =  concat $ DL.map (S.toList) $ M.foldr (:) [] mms
    allIngr =   toIngrList rec
    cantContain = DL.filter (\ing -> not $ ing `DL.elem` bannedIngr) allIngr
    in DL.length cantContain


toAllergDict :: Food -> M.Map String (S.Set String)
toAllergDict (recs,allergs) = M.fromList $ DL.map (\allerg -> (allerg, S.fromList (recs))) allergs

toIngrList :: [Food] -> [String]
toIngrList foods = concat $ DL.map (\(ingr,allergs) -> ingr ) foods

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> String
solution2 xs = let
    rec = DL.map (p parseReceipe) xs
    mms = foldr1 (M.unionWith S.intersection)  $ DL.map (toAllergDict) rec
    redmms = reduceDict' mms
    str = DL.intercalate "," $ M.foldr (:) [] redmms
    in str


-- Transforms the Set to List to call reduceDict
reduceDict' :: M.Map String (S.Set String) -> M.Map String String
reduceDict' mm = let
    convertedMap = M.map (\x -> S.toList x) mm 
    in reduceDict convertedMap


-- copied from Day 16 -- changed type from Int to String
-- reduce the dictionary of  'allergen : [ingredients]' to 'allergen : ingredient'
-- by picking the allergen with only 1 value (1 ingredient in the list)  and removing that ingredient from all the others
-- It assumes that -at every time/iteration- there is 1 allergen with only 1 ingredient
reduceDict :: M.Map String [String] -> M.Map String String
reduceDict dds = go dds (M.fromList []) []
    where go inp out removed
                | M.size inp == 0 = out
                | otherwise = go newInp (M.insert key val' out) (val':removed)
                    where
                        (key,val) = (M.toList $(M.filter (\x -> length x == 1 ) inp )) !! 0
                        val' = head val
                        newInp = M.fromList $ DL.filter (\(_, ls) -> length ls > 0) $ DL.map (\(n, ls) -> (n, DL.filter (/=val') ls)) $ M.toList inp



-- ----------------------------- 
-- Parsing
type Parser = Parsec Void String

getR (Right x) = x
getR (Left x) = error "Parsing Error"

type Food = ([String], [String])

p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")

parseReceipe :: Parser Food
parseReceipe = do
    foods <- many ( many letterChar <* char ' ')
    allergs<- "(contains " *> many letterChar `sepBy1` ", " <* ")"
    return (foods, allergs)
