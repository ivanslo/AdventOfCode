import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print(solution1 $ cleanLine input)
    print("- Part 2 ")
    print( solution2 (map (toInt) $ words input ) )


cleanLine = filter (/= '\n')

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int

castToInteger :: String -> Integer
castToInteger ('+':xs)  = read xs ::Integer
castToInteger x         = read x ::Integer
