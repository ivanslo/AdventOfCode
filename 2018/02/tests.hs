-- Test Cases
--
-- Problem 1
--  input_test.txt
-- Problem 2
--

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 12 $ solution1 $ words input
    print("Problem 2")
    print(solution2 $ words input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
