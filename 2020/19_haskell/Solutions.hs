{-# LANGUAGE OverloadedStrings #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import qualified Data.List.Split as DLS
import Data.Void
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
solution1 xs = length $ filter (\s -> elem s allStrs) strs
    where
        xss = DLS.splitWhen (=="") xs
        rules = map (p ruleP) (xss !! 0)
        allStrs =  generateAll (M.fromList rules)
        strs =  (xss !! 1)


generateAll m = generateAll' m "0"

generateAll' :: M.Map String [[String]] -> String -> [String]
generateAll' m key= go (m M.! key) 
    where 
        go :: [[String]] -> [String]
        go []      = []
        go (x:xs)  = (combinationWith x) ++ (go xs)
            where
                allWithS :: String -> [String]
                allWithS s
                    | s == "11" =  ["(" ++ (intercalate "|" $ go (m M.! "42")) ++ ")+" ++ "(" ++ (intercalate "|" $ go (m M.! "31")) ++ ")+"]
                    | s == "8" =  ["(" ++ (intercalate "|" $ go (m M.! s)) ++ ")+"]
                    | s `M.member` m = go (m M.! s)
                    | otherwise = [s]
                combinationWith :: [String] -> [String]
                combinationWith (s1:[]) = (allWithS s1)
                combinationWith (s1:ss) = (++) <$> (allWithS s1) <*> (combinationWith ss)



-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = length $ filter (\s ->  matchesOk s regex) strs
    where
        xss = DLS.splitWhen (=="") xs
        rules =  map (p ruleP) (xss !! 0)
        regexes = trace'' $ generateAll (M.fromList rules)
        -- masterRule = makeDynamicRules (M.fromList rules)
        regex = regexes !! 0 ++ " "
        strs =  (xss !! 1)

matchesOk :: String -> String -> Bool
matchesOk str reg =  numbersOk
    where
            (_,_,_,arr) = ((str++" ") =~ reg) :: (String,String,String,[String])
            numbersOk = (length arr) == 3 && membersOk arr
            membersOk (a:b:c:[]) = length b == length c

makeDynamicRules :: M.Map String [[String]] -> PS
makeDynamicRules m = go (m M.! "0")  <* eof
    where 
        generateForN :: [String] -> PS
        generateForN [] = error "what"
        generateForN ss = pmakeAndForN ( map (\s -> generateForS s) ss )
        generateForS :: String -> PS
        generateForS s
            | s == "8" = pmakeOrForN $ pmakeRepeating 15 (generateForS "42")
            | s == "11" = pmakeOrForN $ map (\n -> pmakeAndForN [pmakeAndForN $ pmakeRepeating n (generateForS "42"), pmakeAndForN $ pmakeRepeating n (generateForS "31")]) [10,9..1]
            | s `M.member` m = go (m M.! s) 
            | otherwise = pmakeTerminal s

        go strstr 
            | length strstr == 1 = pmakeFor1 (generateForN term1)
            | length strstr == 2 = pmakeOrForN [(generateForN term1),(generateForN term2)]
                where
                    term1 = strstr !! 0
                    term2 = strstr !! 1
                    term3 = strstr !! 2
                    term4 = strstr !! 3
                    term5 = strstr !! 4



-- 42 31
-- 42 42 31 31
-- 42 42 42 31 31 31
-- 42 42 42 42 31 31 31 31


type PS = Parser String

pmakeTerminal :: String -> PS
pmakeTerminal s = try (string s)

pmakeNTerminals :: [String] -> PS
pmakeNTerminals (s:ss) = choice $ map pmakeTerminal ss

pmakeRepeating :: Int -> PS -> [PS]
pmakeRepeating times p1 = map (\n -> pmakeAndForN $ DL.take n $ cycle [p1]) [1..times]

pmakeOrForN :: [PS] -> PS
pmakeOrForN ps = choice ps

pmakeAndForN :: [PS] -> PS
pmakeAndForN ps = try (foldl1 (<>) ps)

pmakeFor1 :: PS -> PS 
pmakeFor1 p0 = try p0

pmakeFor2 :: PS -> PS -> PS
pmakeFor2 p1 p2 = try (p1 <> p2)

pmakeFor3 :: PS -> PS -> PS -> PS
pmakeFor3 p1 p2 p3 = try (p1 <> p2 <> p3)

pmakeFor4 :: PS -> PS -> PS -> PS -> PS
pmakeFor4 p1 p2 p3 p4 = try (p1 <> p2 <> p3 <> p4)

pmakeFor5 :: PS -> PS -> PS -> PS -> PS -> PS
pmakeFor5 p1 p2 p3 p4 p5 = try (p1 <> p2 <> p3 <> p4 <> p5)

pmakeFor6 :: PS -> PS -> PS -> PS -> PS -> PS -> PS
pmakeFor6 p1 p2 p3 p4 p5 p6 = try (p1 <> p2 <> p3 <> p4 <> p5 <> p6)

pmakeOr :: PS -> PS -> PS
pmakeOr pA pB = (try pA <|> try pB)

parses :: PS -> String -> Bool
parses ps s = case parse ps "" s of
                Left x -> False
                Right x -> True
-- ----------------------------- 
-- Types
type Rule = (String, [[String]])

-- ----------------------------- 
-- PARSING
type Parser = Parsec Void String

getR (Right x) = x
getR (Left x) = error "Parsing Error"


p :: Parsec e s c -> s -> c
p rule = (getR) . (parse rule "")


ruleP :: Parser Rule
ruleP = do
    key <- many digitChar <* ":" <* space
    val <- (try finalValP) <|> (valsP `sepBy` "| ")
    return (key, val)

valsP :: Parser [String]
valsP = do
    v <- (many digitChar) `sepBy` " "
    return (filter (/="") v)

finalValP :: Parser [[String]]
finalValP = do
    v <- "\"" *> (string "a" <|> string "b") <* "\""
    return ([[v]])



--- tests =====

-- 0: 4 1 5
-- 1: 2 3 | 3 2
-- 2: 4 4 | 5 5
-- 3: 4 5 | 5 4
-- 4: "a"
-- 5: "b"

p0 :: Parser String
p0 = p4 <> p1 <> p5 <* newline

p4 = "a"
p5 = "b"

p1 :: Parser String
p1 = try (p2 <> p3) <|> try (p3 <> p2)

p2 :: Parser String
p2 = (p4 <> p4) <|> (p5 <> p5)

p3 :: Parser String
p3 = (p4 <> p5) <|> (p5 <> p4)
