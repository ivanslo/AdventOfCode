-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Data.List.Split
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 17 (solution1 $ lines input)
    print("Problem 2")
    test_case 16 (solution2 32 $ lines input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
