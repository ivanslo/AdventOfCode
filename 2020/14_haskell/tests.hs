-- Test Cases

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 165 (solution1 $ input)
    print("Problem 2")
    test_case 208 (solution2 $ testCase2)
    return ()


testCase2 = "mask = 000000000000000000000000000000X1001X\nmem[42] = 100\nmask = 00000000000000000000000000000000X0XX\nmem[26] = 1\n"

test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
