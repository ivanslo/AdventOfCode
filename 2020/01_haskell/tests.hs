
import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 514579 (solution1 $ (map (castToInteger) $ lines input ))
    print("Problem 2")
    test_case 241861950 (solution2 $ (map (castToInteger) $ lines input ))
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)
    
castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
