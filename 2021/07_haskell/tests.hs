-- Test Cases

import Text.Printf
import Data.List
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 37 (solution1 $ head $ lines input ) 

    -- Problem 2
    print("Problem 2")
    test_case 168 (solution2 $ head $ lines input ) 
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
-- test_case e r = 
--     printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int
    
castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
