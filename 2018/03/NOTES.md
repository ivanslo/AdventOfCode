in the Problem 2, I changed the matrix in order to write the number of the ID of the guy there and then check the ID in the area.
It would have been the same to keep the count (1, 2, 3, 4) and then check that a certain area is full of 1's. That certain area is each piece of fabric (window).



The (Int,Int,Int,Int,Int) could have been replaced by:
data Claim = Claim
    { id :: Int
    , x :: Int
    , y :: Int
    , width :: Int
    , height :: Int
    }
    deriving (Show)

parse :: String -> Claim
parse = readClaim . map read . split (dropDelims . dropBlanks $ oneOf "# @,:x")
    where readClaim [id, x, y, width, height] = Claim id x y width height
