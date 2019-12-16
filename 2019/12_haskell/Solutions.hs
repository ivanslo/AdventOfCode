module Solutions(
    solution1,
    solution2
) where

import Parsing 
import Debug.Trace


-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


-- type Vel = (Int, Int, Int)
-- type Pos = (Int, Int, Int)

moveStep :: [Planet] -> [Planet]
moveStep ps = map refreshPos $ zipWith addVel  ps $ map (gravity ps) ps

moveStep' :: Int -> [Planet] -> [Planet]
moveStep' 0 ps = ps
moveStep' n ps = 
    let ps' = moveStep ps
    in trace'(show (ps' !! 0) ) moveStep' (n-1) ps'


moveStepUntil :: Int -> [Planet] -> [Planet] -> Int
moveStepUntil s pl refPlanets
    | ps' == refPlanets = s
    | otherwise = moveStepUntil (s+1) ps' refPlanets
    where ps' = moveStep pl



allEqual :: [Planet] -> [Planet] -> Bool
allEqual (p:ps) (x:xs) = (p == x) && allEqual ps xs

gravity :: [Planet] -> Planet ->  XYZ
gravity ps refP = foldl  (\acc p -> acc + compPos (pos refP) (pos p)) (XYZ 0 0 0) ps

compPos :: XYZ -> XYZ -> XYZ
compPos a b = (XYZ (diff (x a) (x b)) (diff (y a) (y b))(diff (z a) (z b)))

diff :: Int -> Int -> Int
diff f s
    | f == s = 0
    | f < s = 1
    | f > s = -1
    | otherwise = 0

addVel :: Planet -> XYZ -> Planet
addVel planet diff = (Planet (pos planet) (vel planet + diff))

refreshPos :: Planet -> Planet
refreshPos p = (Planet (pos p + vel p) (vel p))

energyPlanet :: Planet -> Int
energyPlanet p = energyXYZ (pos p) * energyXYZ (vel p)

energyXYZ :: XYZ -> Int
energyXYZ (XYZ a b c) = abs a + abs b + abs c

-- ----------------------------- 
-- SOLUTION 1
solution1 :: Int -> String -> Int
-- solution1 :: [Integer] -> Integer
solution1 steps list = trace'("" ++ show (sum $ map energyPlanet $ moveStep' steps $ parseInputToPlanets list)) 0

-- ----------------------------- 
-- SOLUTION 2
solution2 ::  String -> Int
solution2 list = 
    let planets = parseInputToPlanets list
    in moveStepUntil 1 planets planets
