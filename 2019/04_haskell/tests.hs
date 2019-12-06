-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 1 (solution1 111111 111111)
    test_case 0 (solution1 223450 223450)
    test_case 0 (solution1 123789 123789)
    print("Problem 2")
    test_case 0 0
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
-- test_case e r = 
--     printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)
    
castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
