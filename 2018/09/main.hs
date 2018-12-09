import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    -- print (solution1 471 72026)
    print (solution1Seq 471 72026)
    -- print( solution1 (map (toInt) $ words input ) )
    print("- Part 2 ")
    -- print (solution1 471 (72026*100))
    print (solution1Seq 471 (72026*100))
    -- print( solution2 (map (toInt) $ words input ) )


toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int
