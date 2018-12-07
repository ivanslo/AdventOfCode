-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Solutions

main = do
    print("Problem 1")
    test_case 0 0
    print("Problem 2")
    test_case 0 0
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
