import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 2 (solution1 $ lines input)
    print("Problem 2")
    test_case 1 (solution2 $ lines input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
