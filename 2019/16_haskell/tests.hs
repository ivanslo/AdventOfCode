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
    print("Problem 1")
    print(" " ++ (show $ solution1 $ cleanLine input))
    print("starts with 24176176 - " ++ (show $ solution1 $ "80871224585914546619083218645595"))
    print("starts with 73745418 - " ++ (show $ solution1 $ "19617804207202209144916044189917"))
    print("starts with 52432133 - " ++ (show $ solution1 $ "69317163492948606335995924319873"))
    print("Problem 2")
    print("starts with 84462026 - "++ (show $ solution2 $  "03036732577212944063491565474664" ))
    print("starts with 78725270 - "++ (show $ solution2 $  "02935109699940807407585447034323" ))
    print("starts with 53553731 - "++ (show $ solution2 $  "03081770884921959731165446850517" ))
    return ()


cleanLine = filter (/= '\n')

test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
-- test_case e r = 
--     printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)
    
castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
