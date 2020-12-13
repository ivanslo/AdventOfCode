module Solutions(
    solution1,
    solution2,
) where

import Debug.Trace
import qualified Data.Matrix as M

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = manhattan $ foldl operate1 (0,0,1,0) (map p xs)

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = manhattan $ foldl operate2 (0,0,10,1) (map p xs)

-- -----------------------------

manhattan :: Ship -> Int
manhattan (x,y,_,_) = abs x + abs y

operate1 :: Ship -> NavInst -> Ship
operate1 s (R, n) = rotate' s R n
operate1 s (L, n) = rotate' s L n
operate1 s (d, n) = moveShip s d n

operate2 :: Ship -> NavInst -> Ship
operate2 s (R, n) = rotate' s R n
operate2 s (L, n) = rotate' s L n
operate2 s (F, n) = moveShip s F n
operate2 s (d, n) = moveWaypoint s d n

moveWaypoint :: Ship -> Direction -> Int -> Ship
moveWaypoint (x,y,dx,dy) N n = (x, y, dx, dy+n)
moveWaypoint (x,y,dx,dy) S n = (x, y, dx, dy-n)
moveWaypoint (x,y,dx,dy) E n = (x, y, dx+n, dy)
moveWaypoint (x,y,dx,dy) W n = (x, y, dx-n, dy)

moveShip :: Ship -> Direction -> Int -> Ship
moveShip (x,y,dx,dy) F n = (x+dx*n, y+dy*n, dx, dy)
moveShip (x,y,dx,dy) N n = (x, y+n, dx, dy)
moveShip (x,y,dx,dy) S n = (x, y-n, dx, dy)
moveShip (x,y,dx,dy) E n = (x+n, y, dx, dy)
moveShip (x,y,dx,dy) W n = (x-n, y, dx, dy)

rotate' :: Ship -> Direction -> Int -> Ship
rotate' (x,y,dx,dy) d n =  (x,y, dx',dy')
    where 
        dx' = mat M.! (1,1)
        dy' = mat M.! (2,1)
        mat = rotM * M.fromList 2 1 [dx,dy]
        rotM = case d of
            L -> multNTimes t rotL
            R -> multNTimes t rotR
            where t = div n 90


multNTimes :: Int -> M.Matrix Int -> M.Matrix Int
multNTimes times m = foldl (*) (M.identity 2) $ take times $ cycle [m]

rotR = M.fromList 2 2 [0,1,-1,0]
rotL = M.fromList 2 2 [0,-1,1,0]

-- ----------------------------- 
-- Types

type Ship = (Int, Int, Int, Int)
type NavInst = (Direction, Int)
data Direction = E | W | N | S | F | L | R  deriving (Show)


-- ----------------------------- 
-- Parsing

p :: String -> NavInst
p ('W':x) = (W, (asInt x))
p ('E':x) = (E, (asInt x))
p ('N':x) = (N, (asInt x))
p ('S':x) = (S, (asInt x))
p ('F':x) = (F, (asInt x))
p ('L':x) = (L, (asInt x))
p ('R':x) = (R, (asInt x))

asInt :: String -> Int
asInt x = read x :: Int
