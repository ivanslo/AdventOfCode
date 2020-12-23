-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case "67384529" (solution1 "389125467")
    print("Problem 1")
    test_case "149245887792" (solution2 "389125467")
    return ()


test_case e r = 
    printf " [%s] - expects %s and returned %s\n" (show (e == r) :: String)  (e :: String) (r :: String)
