import Solutions

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 $ lines input ) 
    print("- Part 2 ")
    -- print( solution2 (map (toInt) $ words input ) )


toInt :: String -> Int
toInt ('+':xs)  = read xs ::Int
toInt x         = read x ::Int
