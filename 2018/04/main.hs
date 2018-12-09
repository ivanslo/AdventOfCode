import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ lines input )
    print("- Part 2 ")
    print( solution2 $ lines input )


toInt :: String -> Integer
toInt ('+':xs)  = read xs ::Integer
toInt x         = read x ::Integer
