-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    -- Problem 1
    print("Problem 1")
    test_case 37 ( solution1 $ lines input )

    -- Problem 2
    print("Problem 2")
    test_case 26 ( solution2 $ lines input )


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
