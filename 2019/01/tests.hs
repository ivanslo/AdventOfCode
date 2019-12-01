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
    test_case 33583 (solution1 $ (map (castToInteger) $ lines input ))
    print("Problem 2")
    test_case 966 (solution2  [1969])
    test_case 50346 (solution2  [100756])
    return ()

castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)
    
