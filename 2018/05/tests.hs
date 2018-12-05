-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Solutions

main = do
    input <- getContents
    let parsedInput = concat $ words input
    print("Problem 1")
    test_case 10 ( solution1 $ parsedInput )
    print("Problem 2")
    test_case 4 ( solution2 $ parsedInput )
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
