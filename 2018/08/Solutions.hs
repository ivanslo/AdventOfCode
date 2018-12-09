module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Parsec
import Data.Either
import Data.Char
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

type Header = (Int, Int)
data Node = Node 
    { header :: Header -- children and metadata amount
    , children :: [Node]
    , metadata :: [Int] 
    } | Empty

instance Show Node where
    show node = "Header: " ++ (show $ header node) ++ " | Meta: " ++ (show $ metadata node) ++ "\n  ch: " ++ show (children node) ++ ""

parseHeader :: Parsec String () Header
parseHeader = do
    x <- many1 digit
    spaces
    y <- many1 digit
    return (toInt x, toInt y)

parseMeta :: Parsec String () Int
parseMeta = do
    spaces
    m <- many1 digit
    return (toInt m)

toInt :: String -> Int
toInt str = read str :: Int

parseNode :: Parsec String () Node
parseNode = do
    spaces
    header <- parseHeader

    children <- count (fst header) parseNode
    meta <- count (snd header) parseMeta

    return (Node header children meta)

parseInput :: String -> Either ParseError Node
parseInput = parse parseNode ""

-- utility to clean up the Either hell
cleanParsing :: Either ParseError Node -> Node
cleanParsing probableNode =
    case probableNode of
        Left msg -> Node (0,0) [] []
        Right node -> node


------- SOLUTION 1

solution1 :: String -> Int
solution1 list = addMetas $ cleanParsing $ parseInput list


addMetas :: Node -> Int
addMetas node =
    let childSum = sum $ map addMetas (children node)
    in childSum + sum (metadata node)


------- SOLUTION 2

solution2 :: String -> Int
solution2 list = addMetaDif $ cleanParsing $ parseInput list


addMetaDif :: Node -> Int
addMetaDif node
    -- condition 1: if no children, is the sum of it's metadata
    | (length (children node)) == 0 = sum (metadata node)
    -- condition 2: if children, then count the childrens' value pointed by the metadata (if exists)
    | otherwise = 
        let childs = (metadata node)
        in sum $ addChilds childs (children node) addMetaDif

addChilds :: [Int] -> [Node] -> (Node -> Int) -> [Int]
addChilds [] (chs) fn = []
addChilds (i:ix) (chs) fn =
    let first = if i <= length chs then (fn (chs !! (i-1))) else 0
    in first:addChilds ix chs fn



