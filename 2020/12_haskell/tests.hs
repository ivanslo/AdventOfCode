-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 25 (solution1 $ lines input )
    test_case 25 (solution1' $ lines input )
    -- Problem 2
    print("Problem 2")
    -- test_case 286 (solution2 $ lines input )
    -- test_case 286 (solution2' $ lines input )
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
