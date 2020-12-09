-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 0 (solution1 (lines input) 5)

    -- Problem 2
    print("Problem 2")
    test_case 62 (solution2 (lines input) 5)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
