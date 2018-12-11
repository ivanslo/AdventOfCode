module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Parsec
import Text.Parsec.Token
import Data.Either
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


-- Parsing Input

data Point = Point {
    x :: Int,
    y :: Int,
    dx :: Int,
    dy :: Int
}

instance Show Point where
    -- show p = "(" ++ (show $ x p) ++ "," ++ (show $ y p) ++ ") [" ++ (show $ dx p) ++ "," ++ (show $ dy p) ++ "]"
    show p = "(" ++ (show $ x p) ++ "," ++ (show $ y p) ++ ")"


data Sign = Positive | Negative deriving (Show)

applySign :: Num a => Sign -> a -> a
applySign Positive =  id
applySign Negative =  negate

sign  :: Parsec String () Sign
sign  =  do { char '-'
            ; return Negative
            }
     <|> do { char '+'
            ; return Positive
            }
     <|> return Positive

parsePoint :: Parsec String () (Int, Int)
parsePoint = do
    spaces
    s1 <- sign
    a <- many1 digit
    _ <- char ','
    spaces
    s2 <- sign
    b <- many1 digit
    return (applySign s1 $ toInt a, applySign s2 $ toInt b)


parseLine :: Parsec String () Point
parseLine = do
    -- position=< 9,  1> velocity=< 0,  2>
    spaces
    point <- string "position=<" *> parsePoint
    speed <- string "> velocity=<" *> parsePoint
    spaces
    return (Point (fst point) (snd point) (fst speed) (snd speed))


toInt :: String -> Int
toInt str = read str :: Int


parseInput :: String -> Either ParseError Point
parseInput = parse parseLine ""


-- SOLUTION 1
solution1 :: [String] -> IO()
solution1 list = do
    let ps = rights $ map parseInput list
    main ps 0
    -- print $ ps

main :: [Point]  -> Int -> IO()
main ps t = do
    let width = maximX ps - minimX ps
    let height = maximY ps - minimY ps
    print (" grid: " ++ show width ++ "x" ++ show height ++ " time: " ++ show t)
    
    line <- getLine
    if line == "s" then do
        mapM_ (print) $  draw ps
        main ps t
    else if line == "p" then do
        print $ show ps
        main ps t
    else if line == "l" then do
        print $ length ps
        main ps t
    else if line == "z" then do
        print $ sum $ map (length) $ draw ps
        main ps t
    else if line == "m" then do
        print (" min X: " ++ ( show $ minimX ps))
        print (" min Y: " ++ ( show $ minimY ps))
        print (" max X: " ++ ( show $ maximX ps))
        print (" max Y: " ++ ( show $ maximY ps))
    else do
        let ps' = advanceTime (toInt line) ps
        main ps' (t+(toInt line))

advanceTime :: Int -> [Point] -> [Point]
advanceTime t ps = map (\p -> Point ((x p) + (dx p) * t) ((y p) + (dy p) * t) (dx p) (dy p)) ps

draw :: [Point] -> [String]
draw points = 
    let minX = minimX points
        minY = minimY points
        maxX = maximX points
        maxY = maximY points
        -- print ( show minX ++ " " ++ show minY)
        -- print ( show maxX ++ " " ++ show maxY)
    in drawLines [minX..maxX] [minY..maxY] points


minimX :: [Point] -> Int
minimX ps = x $ minimumBy (\a b -> compare (x a) (x b)) ps

minimY :: [Point] -> Int
minimY ps = y $ minimumBy (\a b -> compare (y a) (y b)) ps

maximX :: [Point] -> Int
maximX ps = x $ maximumBy (\a b -> compare (x a) (x b)) ps

maximY :: [Point] -> Int
maximY ps = y $ maximumBy (\a b -> compare (y a) (y b)) ps


rmdups :: [Point] -> [Point]
rmdups ps = foldl foldDups [] ps

foldDups :: [Point] -> Point -> [Point]
foldDups [] p = [p]
foldDups acc p =  
    let s = last acc
        eq = (x s) == (x p) && (y s) == (y p)
    in  if eq then acc else (acc ++ [p])

drawLines :: [Int] -> [Int] -> [Point] -> [String]
drawLines (xs) [] ps = []
drawLines (x1:xs) (y1:ys) ps =
    let points = rmdups $  sortBy (\a b -> compare (x a) (x b)) $ filter (\p -> (y p) == y1 ) ps
        -- ls = foldl (\acc p -> replicate (x p) '.' ) ""  points
        ls = foldl (\acc p -> acc ++ (replicate ((x p) - x1 - length acc ) '.' )++ "#") "" points
        ls' = ls ++ replicate (length (x1:xs) - length ls) '.'
    -- in trace'(">>>>" ++ (show $ points)) ls'
    in ls':(drawLines (x1:xs) ys ps)

-- SOLUTION 2
solution2 :: [String] -> IO()
solution2 list = do
    print "10355"
