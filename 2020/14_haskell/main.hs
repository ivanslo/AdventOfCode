import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ input )
    print("- Part 2 ")
    print( solution2 $ input )
