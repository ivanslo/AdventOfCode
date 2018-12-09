import Solutions

main = do
    input <- getContents
    let line = cleanLine input
    print("- Part 1 ")
    print (solution1 line)
    print("- Part 2 ")
    print (solution2 line)


cleanLine = filter (/='\n')

toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int
