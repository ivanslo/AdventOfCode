module Solutions(
    solution1,
    solution2
) where


import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

--- UTILITIES

-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 list = countTrees list

countTrees :: [String] -> Int
countTrees ls = countTrees' 0 0 ls

countTrees' :: Int -> Int -> [String] -> Int
countTrees' count xpoint [] = count
countTrees' count xpoint (x:xs) 
    | (x!!idx) == '#' = countTrees' (count+1) (xpoint+3) xs
    | otherwise = countTrees' (count) (xpoint+3) xs
    where idx = mod xpoint (length x)

-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 list = 
    let a = countTrees_ list 1 1
        b = countTrees_ list 3 1
        c = countTrees_ list 5 1
        d = countTrees_ list 7 1
        e = countTrees_ list 1 2
    in a * b * c * d * e

countTrees_ :: [String] -> Int -> Int -> Int
countTrees_ ls slopeX slopeY = countTrees_' 0 0 slopeX slopeY ls

countTrees_' :: Int -> Int -> Int -> Int -> [String] -> Int
countTrees_' count xpoint sx xy [] = count
countTrees_' count xpoint sx sy (x:xs) 
    | (x!!idx) == '#' = countTrees_' (count+1) (xpoint+sx) sx sy rest
    | otherwise = countTrees_' (count) (xpoint+sx) sx sy rest
    where 
        idx = mod xpoint (length x)
        rest = drop (sy-1) xs


