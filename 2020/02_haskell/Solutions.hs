module Solutions(
    solution1,
    solution2
) where


import Debug.Trace
-- Requires to have regex-posix installed: `cabal install regex-posix`
import Text.Regex.Posix

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

--- UTILITIES

howMany :: (a -> Bool) -> [a] -> Int
howMany cond xs = length $ filter cond xs

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int


parseLine :: String -> (Char, Int, Int, String)
parseLine line = 
    let m = line =~ "([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" :: [[String]]
        m' = m !! 0
        l = toInt (m'!!1)
        h = toInt (m'!!2)
        c = head (m'!!3)
        s = m'!!4
    in (c,l,h,s)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 list = howMany (==True) $ map (validPassword . parseLine) list

validPassword :: (Char, Int, Int, String) -> Bool
validPassword (c, low, high, passwd) =
    let repetitions = howMany (==c) passwd
    in repetitions <= high && repetitions >= low

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 list = howMany (==True) $ map (validPassword' . parseLine) list

validPassword' :: (Char, Int, Int, String) -> Bool
validPassword' (c, low, high, passwd)
    | one && not two = True
    | two && not one = True
    | otherwise = False
    where one = (passwd !! (low-1)) == c
          two = (passwd !! (high-1)) == c
