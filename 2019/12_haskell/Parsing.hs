module Parsing(
    XYZ (..),
    Planet (..),
    parseInputToPlanets
) where

import Text.Parsec

data XYZ  = XYZ
    { x :: Int
    , y :: Int
    , z :: Int
    }

instance Show XYZ where
    show xyz = "<" ++ (show $ x xyz) ++ ", " ++ (show $ y xyz) ++ ", " ++ (show $ z xyz) ++ ">"

instance Num XYZ  where
    (XYZ x y z) + (XYZ a b c)= (XYZ (x+a) (y+b) (z+c))

instance Eq XYZ   where
    (XYZ x y z) == (XYZ a b c) = x == a && y == b && z == c

data Planet = Planet
    { pos :: XYZ
    , vel :: XYZ
    }

-- (+++) :: Planet -> XYZ -> Planet
-- (+++) p change = 

instance Show Planet where
    show planet = "pos=" ++ (show $ pos planet) ++ " vel="++ (show $ vel planet)

instance Eq Planet where
    a  == b  = vel a == vel b && pos a == pos b


parseNeg :: Parsec String () Int
parseNeg = do
    _ <- char '-'
    s <- many1 digit
    return (toInt $ "-" ++ s)

parsePos :: Parsec String () Int
parsePos = do
    s <- many1 digit
    return (toInt s)

parseNumber :: Parsec String () Int
parseNumber = do
    -- sign <- char '-'
    n <- parsePos <|> parseNeg
    return n

toInt :: String -> Int
toInt s = read s

parse1Planet :: Parsec String () Planet
parse1Planet = do
    spaces
    _ <- char '<'
    _ <- char 'x'
    _ <- char '='
    x <- parseNumber
    _ <- char ','
    spaces
    _ <- char 'y'
    _ <- char '='
    y <- parseNumber
    _ <- char ','
    spaces
    _ <- char 'z'
    _ <- char '='
    z <- parseNumber
    _ <- char '>'
    return (Planet (XYZ x y z) (XYZ 0 0 0))

parsePlanets :: Parsec String () [Planet]
parsePlanets = do
    p <- many parse1Planet
    return p

parseInput :: String -> Either ParseError [Planet]
parseInput = parse parsePlanets ""

parseInputToPlanets :: String -> [Planet]
parseInputToPlanets s = cleanParsing $ parseInput s

-- utility to clean up the Either hell
cleanParsing :: Either ParseError [Planet] -> [Planet]
cleanParsing probablePlanet =
    case probablePlanet of
        Left msg -> []
        Right msg -> msg
