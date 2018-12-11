import Solutions
import System.IO

main = do
    -- interactive solution
    --  10355 is t when the size of the input is the smallest
    print("- Part 1 ")
    handle <- openFile "input.txt" ReadMode  
    contents <- hGetContents handle  
    solution1 $ lines contents
    hClose handle  



toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int
