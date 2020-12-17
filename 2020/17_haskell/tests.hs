-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 112 (solution1 $ lines input)
    print("Problem 2 --- SLOW")
    test_case 848 (solution2 $ lines input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
