-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Solutions
import System.IO

main = do
    -- input <- getContents
    print("Problem 1")
    handle <- openFile "input_test.txt" ReadMode  
    contents <- hGetContents handle  
    solution1 $ lines contents
    hClose handle  

    -- solution1 $ lines input
    -- print("Problem 2")
    -- solution2 $ lines input
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
