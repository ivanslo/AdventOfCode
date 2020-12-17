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
solution1 :: String -> Int
solution1 xs = let
    (rules,mine,others) = p parseAll xs
    nrs = filter (notComplaint rules) $ concat  others
    in sum nrs

notComplaint :: Rules -> Int -> Bool
notComplaint rules nr = not $ any (\r -> inRule r nr) rules

inRule :: Rule -> Int -> Bool
inRule (name, r1, r2) nr = inRange r1 nr || inRange r2 nr

inRange :: RuleVal -> Int -> Bool
inRange (l,h) n = n >= l && n <= h


-- ----------------------------- 
-- SOLUTION 2
solution2 :: String -> Int
solution2 xs = let
    notes = p parseAll xs
    (rules,mine,others) = discardInvalidTickets $ notes
    mr = map posList $ map binFold  $ map (ruleMap others) rules
    dict1 = reduceDict $ M.fromList $ zipWith (\(name,_,_) val -> (name, val)) rules mr
    dict2 = M.filterWithKey (\k _ -> isPrefixOf "departure " k) dict1 -- ^ only then ones with 'departure *'
    coolValues =  map (\(name, idx) -> mine !! idx) (M.toList dict2)
    in foldl1 (*) coolValues

posList :: [Bool] -> [Int]
posList bbs = go bbs 0
    where   
            go :: [Bool] -> Int -> [Int]
            go [] n     = []
            go (b:bs) n = if b then n:go bs (n+1) else go bs (n+1)


discardInvalidTickets :: Notes -> Notes
discardInvalidTickets (rules, tt, tts) = let
        newTts = filter (\nrs -> not $ any (notComplaint rules) nrs) tts
        in (rules, tt, newTts)


-- reduce the dictionary of  'positionName : [column]' to 'positionName : column'
-- by picking the positionName with only 1 column, and removing that column from all the others
reduceDict :: M.Map String [Int] -> M.Map String Int
reduceDict dds = go dds (M.fromList []) []
    where go inp out removed 
                | M.size inp == 0 = out
                | otherwise = go newInp (M.insert key val' out) (val':removed)
                    where   
                        (key,val) = (M.toList $(M.filter (\x -> length x == 1 ) inp )) !! 0
                        val' = head val 
                        newInp = M.fromList $ filter (\(_, ls) -> length ls > 0) $ map (\(n, ls) -> (n, filter (/=val') ls)) $ M.toList inp


binFold :: [[Bool]] -> [Bool]
binFold tfw = foldr1 (\x acc -> zipWith (&&) x acc ) tfw

ruleMap :: [Tickets] -> Rule -> [[Bool]]
ruleMap (tt:tts) rule = (map (inRule rule) tt):(ruleMap tts rule)
ruleMap ([]) rule = []

-- ----------------------------- 
-- Parsing

type Notes = (Rules, Tickets, [Tickets])

type RuleVal = (Int, Int)
type Rule = (String,RuleVal,RuleVal)
type Rules = [Rule]
type Tickets = [Int]

type Parser = Parsec Void String

getR (Right x) = x
getR (Left x) = error "Parsing Error"

p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")

parseAll :: Parser Notes
parseAll = do
    rules <-  manyTill ruleP newline
    _ <- string "your ticket:" <* newline
    myT <- ticketsP
    _ <- newline
    _ <- string "nearby tickets:" <* newline
    otT <- many ticketsP
    return (rules, myT, otT)

ticketsP :: Parser Tickets
ticketsP = do
    tickets <- many digitChar `sepBy1` "," <* newline
    return (map asInt tickets)

ruleP :: Parser Rule
ruleP = do
    ruleName <-  many (alphaNumChar <|> char ' ') <* ": " 
    rule1 <- ruleValP <* " or "
    rule2 <- ruleValP
    _ <- newline
    return (ruleName, rule1, rule2 )

ruleValP :: Parser RuleVal
ruleValP = (\a b -> (a,b)) <$> L.decimal <* "-" <*> L.decimal

asInt :: String -> Int
asInt s = read s :: Int
