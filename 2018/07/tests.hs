-- Test Cases
--
-- Problem 1
--
-- Problem 2
--

import Text.Printf
import Solutions2

main = do
    input <- getContents
    print("Problem 1")
    test_case "CABDFE" (solution1 $ lines input)
    -- print("Problem 2")
    -- test_case 0 0
    return ()


test_case e r = 
    printf " [%s] - expects %s and returned %s\n" (show (e == r) :: String)  (e ::String) (r :: String)
    
