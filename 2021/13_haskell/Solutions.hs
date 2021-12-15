module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split
import qualified Data.Set as S
import Text.Regex.Posix

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- parsing
parsePoints :: [String] -> [(Int, Int)]
parsePoints ss = map parsePoint ss

parsePoint :: String -> (Int,Int)
parsePoint ss = 
    let [x,y] = splitOn "," ss
    in (toInt x, toInt y)

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

parseInstrucs :: [String] -> [(Int, Int)]
parseInstrucs ss = map parseInstruc ss

parseInstruc :: String -> (Int, Int)
parseInstruc ss = 
    let (_, _, _,[coord,valS]) = ss =~ ".* (.*)=(.*)" :: (String, String, String, [String])
    in makeInstruc coord valS

makeInstruc :: String -> String -> (Int, Int)
makeInstruc "x" s = (toInt s, 0)
makeInstruc "y" s = (0, toInt s)
makeInstruc _ _ = error "what"

-- ----------------------------- 
-- functions

maxX ps = maximum $ map (\(x,y) -> x) ps

maxY ps = maximum $ map (\(x,y) -> y) ps

minX ps = minimum $ map (\(x,y) -> x) ps

minY ps = minimum $ map (\(x,y) -> y) ps


foldPaper :: [(Int,Int)] -> (Int,Int) -> [(Int,Int)]
foldPaper points (lim,0) = 
    let maxX' = maxX points
        minX' = minX points
        below = filter (\(x,y) -> x < lim) points
        above = filter (\(x,y) -> x > lim) points
        above' =  map (\(x,y) -> (maxX'-x+minX',y)) above
    in  unique $ below ++ above'

foldPaper points (0,lim) = 
    let maxY' = maxY points
        minY' = minY points
        below = filter (\(x,y) -> y < lim) points
        above = filter (\(x,y) -> y > lim) points
        above' =  map (\(x,y) -> (x, maxY'-y+minY')) above
    in  unique $ below ++ above'
    -- in [(0,3)]


unique :: [(Int, Int)] -> [(Int, Int)]
unique lst = S.toList $ S.fromList lst

foldPaperMany :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
foldPaperMany points [] =  points
foldPaperMany points (i:is) = foldPaperMany (foldPaper points i) is


-- printing

printPoint :: [(Int, Int)] -> (Int,Int) -> IO ()
printPoint ps p = do
    putStr $ if (elem p ps) then "#" else "."

printLine :: Int -> Int -> [(Int, Int)] -> IO ()
printLine mX y ps = do
    mapM_ (\x -> printPoint ps (x,y))  [0..mX]
    putStrLn ""

printLines :: Int -> Int -> [(Int, Int)] -> IO ()
printLines mX mY ps = do
    mapM_ (\y -> printLine mX y ps) [0..mY]

printPoints :: [(Int, Int)] -> IO ()
printPoints ps = do
    let maxX' = maxX ps
    let maxY' = maxY ps
    printLines maxX' maxY' ps

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = 
    let [ps, is] = splitOn [""] xs
        points = parsePoints ps
        instr =   parseInstrucs is
        folded  = foldPaper points (head instr)
    in length $ folded


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> IO ()
solution2 xs =
    let [ps, is] = splitOn [""] xs
        points =  parsePoints ps
        instr =   parseInstrucs is
        folded  = foldPaperMany points instr
    in  printPoints folded
