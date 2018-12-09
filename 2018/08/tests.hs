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
    let line = cleanLine input
    print("Problem 1")
    -- print (cleanLine input )
    test_case 138 (solution1 line)
    print("Problem 2")
    test_case 66 (solution2 line)
    return ()


cleanLine = filter (/='\n')

test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
