-- import Solutions
import SolutionsImproved

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 (map (toInt) $ words input ) )
    print("- Part 2 ")
    print( solution2 (map (toInt) $ words input ) )


toInt :: String -> Integer
toInt ('+':xs)  = read xs ::Integer
toInt x         = read x ::Integer

