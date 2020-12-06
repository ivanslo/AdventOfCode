-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 11 ( solution1 $ lines input )
    --  solution1 (map (toInt) $ words input ) 
    --  solution1 $ lines input 

    -- Problem 2
    print("Problem 2")
    test_case 6 ( solution2 $ lines input )
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
