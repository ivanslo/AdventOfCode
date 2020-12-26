import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 "476138259" )
    print("- Part 2 ")
    print( solution2 "476138259" 10000000 1000000)
