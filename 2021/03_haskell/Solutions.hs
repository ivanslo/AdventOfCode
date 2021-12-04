module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Char
import Data.List

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
trace'' s = trace' (show s) s


-- ----------------------------- 
-- functions

-- countOnesPerPosition "1001" [3,3,3,3] => [4,3,3,4]
countOnesPerPosition :: String -> [Int] -> [Int]
countOnesPerPosition (x:_) (c:[])
    | x == '1'  = [c+1]
    | otherwise = [c]
countOnesPerPosition (x:[]) (c:_)
    | x == '1'  = [c+1]
    | otherwise = [c]
countOnesPerPosition (x:xs) (c:cs)
    | x == '1'  = (c+1:(countOnesPerPosition xs cs))
    | otherwise = (  c:(countOnesPerPosition xs cs))

-- getMostCommon [1,2,3,4,5] 3 => ['0','0','0','1','1']
getMostCommon :: [Int] ->  Int -> [String]
getMostCommon ([])   n = []
getMostCommon (x:xs) n
    | x == (div n 2) && 0 == (mod n 2) = ("1":(getMostCommon xs n))
    | x > (div n 2) = ("1":(getMostCommon xs n))
    | otherwise     = ("0":(getMostCommon xs n))


-- 
opposite :: Char -> Char
opposite '1' = '0'
opposite '0' = '1'

-- 
toDec :: String -> Int
toDec = foldl' (\acc x -> acc * 2 + digitToInt x) 0

--
onesAtPosition :: String -> Int -> Int
onesAtPosition xs pos
    | xs !! pos == '1'  = 1
    | otherwise         = 0

zerosAtPosition :: String -> Int -> Int
zerosAtPosition xs pos
    | xs !! pos == '1'  = 0
    | otherwise         = 1


filterInputWithCInPos :: [String] -> Char -> Int -> [String]
filterInputWithCInPos ss c p = filter (\s -> (s !! p) == c) ss

asChar :: String -> Char
asChar s = head s :: Char


-- using the most common
iterateUntilOneMC :: [String] -> String
iterateUntilOneMC ss = go ss 0
    where 
        go ([]) pos = []
        go (x:[]) pos = x
        go xs pos = 
            let remaining = length xs
                counting =   foldr (\x acc-> acc + onesAtPosition x pos) 0 xs
                (mc:mcs) = concat $ getMostCommon (counting:[]) remaining
                xs' =  filterInputWithCInPos xs mc pos
            in go xs' (pos+1)

-- using the least common
-- this is bad, duplicated code - but don't have the brain to think anymore
iterateUntilOneLC :: [String] -> String
iterateUntilOneLC ss = go ss 0
    where 
        go ([]) pos = []
        go (x:[]) pos = x
        go xs pos = 
            let remaining = length  xs
                counting =  foldr (\x acc-> acc + onesAtPosition x pos) 0 xs
                (mc:mcs) =  concat $ getMostCommon (counting:[]) remaining
                xs' = filterInputWithCInPos xs (opposite mc) pos
            in go xs' (pos+1)

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = 
    let counting = foldr countOnesPerPosition (repeat 0) xs
        inputLength = length xs
        mc = getMostCommon counting inputLength
        n1 = concat mc
        n2 = map opposite n1
    in toDec  n1 * toDec n2


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = 
    let n1 =  iterateUntilOneMC xs
        n2 = iterateUntilOneLC xs
    in toDec n1 * toDec n2
