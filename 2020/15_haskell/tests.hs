-- Test Cases

import Text.Printf
import Solutions

main = do
    -- Problem 1
    print("Problem 1")
    print("Problem 1")
    test_case 436 (solution1 "0,3,6")
    test_case 1 (solution1 "1,3,2")
    test_case 10 (solution1 "2,1,3")
    test_case 27 (solution1 "1,2,3")
    test_case 78 (solution1 "2,3,1")
    test_case 438 (solution1 "3,2,1")
    test_case 1836 (solution1 "3,1,2")

    -- Problem 2
    print("Problem 2 -- (warning: very slow)")
    test_case 175594 (solution2 "0,3,6")
    test_case 2578 (solution2 "1,3,2")
    test_case 3544142 (solution2 "2,1,3")
    test_case 261214 (solution2 "1,2,3")
    test_case 6895259 (solution2 "2,3,1")
    test_case 18 (solution2 "3,2,1")
    test_case 362 (solution2 "3,1,2")
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
