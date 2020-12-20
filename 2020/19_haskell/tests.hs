-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    -- print("Problem 1")
    -- test_case 2 (solution1 $ lines input)

    -- Problem 2
    print("Problem 2")
    test_case 12 (solution2 $ lines input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
