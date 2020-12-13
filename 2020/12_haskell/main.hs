import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ lines input )
    print( solution1' $ lines input )
    print("- Part 2 ")
    print( solution2 $ lines input )
    print( solution2' $ lines input )


toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
