
import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 820 (solution1 $ lines input)
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
