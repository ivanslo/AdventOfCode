import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ head $ lines input )
    print("- Part 2 ")
    print( solution2 $ head $ lines input )


toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
