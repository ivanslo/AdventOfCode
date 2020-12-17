{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances    #-}

module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = let
    points  = parseInput3D xs
    points' = iterateTimes 6 points
    in length points'

-- ----------------------------- 
-- SOLUTION 2

solution2 :: [String] -> Int
solution2 xs = let
    points  = parseInput4D xs
    points' = iterateTimes 6 points
    in length points'

-- ----------------------------- 
-- Utilities

iterateTimes :: (PP a, Eq a) => Int -> [a] -> [a]
iterateTimes 0 ps = ps
iterateTimes t ps = let
    minpoint = foldr1 minP  ps
    maxpoint = foldr1 maxP ps
    universe = getUniverse minpoint maxpoint
    ps' = computeNew universe ps
    in iterateTimes (t-1) ps'


computeNew :: (PP a, Eq a) => [a] -> [a] -> [a]
computeNew space actives = filter isNowActivate space
    -- WARNING: this is slow. 
    -- Try: using a Map instead of a list, specially for checking `p `elem` actives.
    -- Try2: istead of comparing `p elem actives` neighbours times (85) check each active at distance 1 to point.
    where isNowActivate point
            | point `elem` actives = activeNeighbours == 2 || activeNeighbours == 3
            | otherwise            = activeNeighbours == 3
            where   activeNeighbours = length $ filter (\p -> p `elem` actives) (neighbours point)


neighbours3DIdx :: [(Int,Int,Int)]
neighbours3DIdx = delete (0,0,0) $ (,,) <$> [0,1,(-1)] <*> [0,1,(-1)] <*> [0,1,(-1)]

neighbours4DIdx :: [(Int,Int,Int,Int)]
neighbours4DIdx = delete (0,0,0,0) $ (,,,) <$> [0,1,(-1)] <*> [0,1,(-1)] <*> [0,1,(-1)] <*> [0,1,(-1)]
-- ----------------------------- 
-- Types
type Point3D = (Int, Int, Int)      -- x,y,z
type Point4D = (Int, Int, Int, Int) -- x,y,z,w

class PP a where
    neighbours :: a -> [a]
    minP :: a -> a -> a
    maxP :: a -> a -> a
    getUniverse :: a -> a -> [a]

instance PP Point3D where
    neighbours (x,y,z) = map (\(nx, ny, nz) -> (x+nx, y+ny, z+nz)) neighbours3DIdx
    minP (x1,y1,z1) (x2,y2,z2) = (min x1 x2, min y1 y2, min z1 z2)
    maxP (x1,y1,z1) (x2,y2,z2) = (max x1 x2, max y1 y2, max z1 z2)
    getUniverse (x1,y1,z1) (x2,y2,z2) = (,,) <$> [(x1-1)..(x2+1)] <*> [(y1-1)..(y2+1)] <*> [(z1-1)..(z2+1)]

instance PP Point4D where
    neighbours (x,y,z,w) = map (\(nx, ny, nz, nw) -> (x+nx, y+ny, z+nz, w+nw)) neighbours4DIdx
    minP (x1,y1,z1,w1) (x2,y2,z2,w2) = (min x1 x2, min y1 y2, min z1 z2, min w1 w2)
    maxP (x1,y1,z1,w1) (x2,y2,z2,w2) = (max x1 x2, max y1 y2, max z1 z2, max w1 w2)
    getUniverse (x1,y1,z1,w1) (x2,y2,z2,w2) = (,,,) <$> [(x1-1)..(x2+1)] <*> [(y1-1)..(y2+1)] <*> [(z1-1)..(z2+1)] <*> [(w1-1)..(w2+1)]

-- ----------------------------- 
-- Parsing

parseInput3D :: [String] -> [Point3D]
parseInput3D ss = concat $ go ss 0
    where   
            go [] y     = []
            go (x:xs) y = (toPoints x 0) : go xs (y+1)
                where   toPoints [] _       = []
                        toPoints ('.':ps) x = toPoints ps (x+1)
                        toPoints ('#':ps) x = (x,y,0):toPoints ps (x+1)

parseInput4D :: [String] -> [Point4D]
parseInput4D ss = concat $ go ss 0
    where   
            go [] y     = []
            go (x:xs) y = (toPoints x 0) : go xs (y+1)
                where   toPoints [] _       = []
                        toPoints ('.':ps) x = toPoints ps (x+1)
                        toPoints ('#':ps) x = (x,y,0,0):toPoints ps (x+1)

