module Solutions(
    solution1,
    solution2,
    solution1',
    solution2'
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
solution1 xs =  manhattanDistance $ pos $ trace'' $ solve1 $ map p xs

manhattanDistance :: Point -> Int
manhattanDistance (Point x y) = abs x + abs y

bepiStart = Bepi (Point 0 0) (Point 1 0)

solve1 :: [NavInst] -> Bepi
solve1 wp = foldl applyInstr bepiStart wp

applyInstr :: Bepi -> NavInst -> Bepi
applyInstr (Bepi (Point x y) (Point dx dy)) (NavInst F n) = Bepi (Point (x+dx*n) (y+dy*n)) (Point dx dy)
applyInstr (Bepi (Point x y) (Point dx dy)) (NavInst E n) = Bepi (Point (x+n) y) (Point dx dy)
applyInstr (Bepi (Point x y) (Point dx dy)) (NavInst W n) = Bepi (Point (x-n) y) (Point dx dy)
applyInstr (Bepi (Point x y) (Point dx dy)) (NavInst N n) = Bepi (Point x (y+n)) (Point dx dy)
applyInstr (Bepi (Point x y) (Point dx dy)) (NavInst S n) = Bepi (Point x (y-n)) (Point dx dy)
applyInstr (Bepi p dir ) (NavInst L n) = Bepi p (rotate dir L n)
applyInstr (Bepi p dir ) (NavInst R n) = Bepi p (rotate dir R n)

rotate :: Point -> Direction -> Int -> Point
rotate dir R degrees =  (\(a:b) -> Point a (head b))  $ M.toList $ rotR t * M.fromList 2 1 [x dir, y dir]
    where t = div degrees 90
rotate dir L degrees =  (\(a:b) -> Point a (head b))  $ M.toList $ rotL t * M.fromList 2 1 [x dir, y dir]
    where t = div degrees 90

rotR times = foldl (*) ident $ take times $ cycle [rotRight]
rotL times = foldl (*) ident $ take times $ cycle [rotLeft]


rotRight :: M.Matrix Int
rotRight = M.fromList 2 2 [0,1,-1,0]
rotLeft :: M.Matrix Int
rotLeft = M.fromList 2 2 [0,-1,1,0]
ident = M.identity 2


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = manhattanDistance $ pos $ trace'' $ solve2 $ map p xs

bepiStart2 = Bepi (Point 0 0) (Point 10 1)

solve2 :: [NavInst] -> Bepi
solve2 wp = foldl applyInstr' bepiStart2 wp

applyInstr' :: Bepi -> NavInst -> Bepi
applyInstr' (Bepi (Point x y) (Point dx dy)) (NavInst F n) = Bepi (Point (x+dx*n) (y+dy*n)) (Point dx dy)
applyInstr' (Bepi p (Point dx dy)) (NavInst E n) = Bepi p (Point (dx+n) dy)
applyInstr' (Bepi p (Point dx dy)) (NavInst W n) = Bepi p (Point (dx-n) dy)
applyInstr' (Bepi p (Point dx dy)) (NavInst N n) = Bepi p (Point dx (dy+n))
applyInstr' (Bepi p (Point dx dy)) (NavInst S n) = Bepi p (Point dx (dy-n))
applyInstr' (Bepi p dir ) (NavInst L n) = Bepi p (rotate dir L n)
applyInstr' (Bepi p dir ) (NavInst R n) = Bepi p (rotate dir R n)

---------------------------------------- second attempt 


solution1' :: [String] -> Int
solution1' xs = manhattan $ foldl operate (0,0,1,0) (map p xs)

solution2' :: [String] -> Int
solution2' xs = manhattan $ foldl operate' (0,0,10,1) (map p xs)

manhattan :: Ship -> Int
manhattan (x,y,_,_) = abs x + abs y

operate' :: Ship -> NavInst -> Ship
operate' s (NavInst R n) = rotate' s R n
operate' s (NavInst L n) = rotate' s L n
operate' s (NavInst F n) = moveShip s F n
operate' s (NavInst d n) = moveWaypoint s d n

operate :: Ship -> NavInst -> Ship
operate s (NavInst R n) = rotate' s R n
operate s (NavInst L n) = rotate' s L n
operate s (NavInst d n) = moveShip s d n

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
            L -> rotL t
            R -> rotR t
            where t = div n 90


-- ----------------------------- 
-- Types

type Ship = (Int, Int, Int, Int)

data Bepi = Bepi { pos:: Point
                 , dir :: Point
                 } deriving (Eq, Show)

data Point = Point { x :: Int
                   , y :: Int 
                   } deriving (Eq, Show)

data NavInst = NavInst { instr :: Direction
                       , factor :: Int
                       } 

data Direction = E | W | N | S | F | L | R  deriving (Show)


-- ----------------------------- 
-- Parsing

p :: String -> NavInst
p ('W':x) = NavInst W (asInt x)
p ('E':x) = NavInst E (asInt x)
p ('N':x) = NavInst N (asInt x)
p ('S':x) = NavInst S (asInt x)
p ('F':x) = NavInst F (asInt x)
p ('L':x) = NavInst L (asInt x)
p ('R':x) = NavInst R (asInt x)


asInt :: String -> Int
asInt x = read x :: Int
