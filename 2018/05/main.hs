import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ concat $ words input )
    print("- Part 2 ")
    print( solution2 $ concat $ words input )

toInt :: String -> Integer
toInt ('+':xs)  = read xs ::Integer
toInt x         = read x ::Integer
