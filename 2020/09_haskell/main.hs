import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 (lines input) 25 )
    print("- Part 2 ")
    print( solution2 (lines input) 25 )


toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
