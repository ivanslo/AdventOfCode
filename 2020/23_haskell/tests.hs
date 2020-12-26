-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case "92658374" (solution1 "389125467")

    print("Problem 1 - 10 moves")
    test_case "92658374" (solution1' "389125467" 10 9)
    print("Problem 1 - 100 moves")
    test_case "67384529" (solution1' "389125467" 100 9)
    print("Problem 2 - 10000000 moves")
    test_case "149245887792" (solution2 "389125467" 10000000 1000000)
    return ()


test_case e r = 
    printf " [%s] - expects %s and returned %s\n" (show (e == r) :: String)  (e :: String) (r :: String)
