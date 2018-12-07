module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List.Split
import Data.List

data Point = Point
    { x :: Int
    , y :: Int
    } deriving (Show, Ord, Eq)

-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


solution1 :: [String] -> Int
-- solution1 list = trace'(show $  map strToPoint list) 0
solution1 list = 
    let points = map strToPoint list
        minp = corner foldyMin points
        maxp = corner foldyMax points
        grid = (Point) <$> [(x minp)..(x maxp)] <*> [(y minp)..(y maxp)]
        newGrid = map (closestTo points) grid
        -- borderPoints = getBorderPoints newGrid minp maxp
        -- NOTE: this is dangerous since we didn't filter the points in the border
        -- yet. If a point marking a border has a super-big area, then the algorithm fails
        -- It should discard all the points that touches the border.
        borderTop = zipWith (Point) [(x minp)..(x maxp)] (cycle [(y minp)])
        borderBot = zipWith (Point) [(x minp)..(x maxp)] (cycle [(y maxp)])
        borderLeft = zipWith (Point) (cycle [(x minp)]) [(y minp)..(y maxp)]
        borderRight = zipWith (Point) (cycle [(x maxp)]) [(y minp)..(y maxp)]
        -- ...

    in trace'(show borderLeft) maximum $map length $ group $ sort newGrid

-- getBorderPoints :: [Point] -> Point -> Point -> [Point]
-- getBorderPoints grid minp maxp = 


closestTo :: [Point] -> Point -> Point
closestTo points gp = calcClosest points gp (Point 0 0) 1000
    -- let ddistances = 

calcClosest :: [Point] -> Point -> Point -> Int -> Point
calcClosest [] g closest dist = closest
calcClosest (p:ps) g closest dist
    | dist' < dist = calcClosest ps g p dist'
    | dist' == dist = calcClosest ps g (Point 0 0) dist
    | otherwise = calcClosest ps g closest dist
    where dist' = distManhattan p g


distManhattan :: Point -> Point -> Int
distManhattan a b = abs ((x a) - (x b)) + abs ((y a) - (y b))

strToPoint :: String -> Point
strToPoint s = 
    let cmp = map toInt $ splitOn ", " s
    in (Point (cmp !! 0) (cmp !! 1))

toInt :: String -> Int
toInt x = read x :: Int

-- minAndMax = topLeft

topLeft :: [Point] -> Int
topLeft [p] = (x p)
topLeft (p:ps) = min (x p) (topLeft ps)


corner :: (Point -> Point -> Point) -> [Point] -> Point
corner foldFn (p:ps) = foldl foldFn p ps

foldyMin :: Point -> Point -> Point
foldyMin acc p = 
        let px = x p
            py = y p
            ax = x acc
            ay = y acc
        in Point (min px ax) (min py ay)


foldyMax :: Point -> Point -> Point
foldyMax acc p = 
        let px = x p
            py = y p
            ax = x acc
            ay = y acc
        in Point (max px ax) (max py ay)


solution2 :: Int -> [String] -> Int
solution2 limit list =
    let points = map strToPoint list
        minp = corner foldyMin points
        maxp = corner foldyMax points
        grid = (Point) <$> [(x minp)..(x maxp)] <*> [(y minp)..(y maxp)]
        newGrid = map (totalDistance points) grid
    in length $ filter (<limit) newGrid

totalDistance :: [Point] -> Point -> Int
totalDistance points g = foldl (\acc p -> acc + distManhattan g p) 0 points
