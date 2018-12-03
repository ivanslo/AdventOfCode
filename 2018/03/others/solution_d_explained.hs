Glad I get to use one of my favorite Haskell data structures -- Map (Int,Int)!

Or well, Map (V2 Int), to take advantage of point-wise addition.

Once we build the map of the claims, we count which points have been claimed more than once:

type Coord = V2 Int
data Rect = R { rStart :: Coord, rSize :: Coord }

tiles :: Rect -> [Coord]
tiles (R start size) = Data.Ix.range (topLeft, bottomRight)
  where
    topLeft = start
    bottomRight = start + size - 1

-- | Build the cloth, with a map from coordinate to number of claims at that coordinate
layTiles :: [Rect] -> Map Coord Int
layTiles = M.fromListWith (+) . map (,1) . concatMap tiles

day02a :: [Rect] -> Int
day02a = length . filter (>= 2) . toList . layTiles

For the second one, we search all of the claims to see if any of them are non-overlapping:

day03b :: [(Int, Rect)] -> Maybe Int
day03b ts = fst <$> find (noOverlap stakes) ts
  where
    stakes = layTiles (map snd ts)

noOverlap :: Map Coord Int -> Rect -> Bool
noOverlap tilesClaimed r = all isAlone (tiles r)
  where
    isAlone c = M.lookup c tilesClaimed == Just 1

I'm doing detailed reflections/writeups for Haskell here if anyone is interested :) https://github.com/mstksg/advent-of-code-2018/blob/master/reflections.md

Ah, and for the parser:

parseLine :: String -> Maybe (Int, Rect)
parseLine = mkLine . mapMaybe readMaybe . words . map onlyDigits
  where
    mkLine [i,x0,y0,w,h] = Just (Rect (V2 x0 y0) (V2 w h))
    mkLine _             = Nothing
    onlyDigits c
      | isDigit c = c
      | otherwise = ' '

