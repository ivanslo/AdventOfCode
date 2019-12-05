module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


solution1 :: [Integer] -> Integer
solution1 list = sum $ map fuelPerMass list

fuelPerMass :: Integer -> Integer
fuelPerMass x
    | res < 0 = 0
    | otherwise = res
    where res = ((toInteger x) `div` 3 )- 2

fuelPerMassRecursive :: Integer -> Integer
fuelPerMassRecursive x 
    | x <= 0 = 0
    | otherwise = fuel + fuelPerMassRecursive fuel
    where fuel = fuelPerMass x
-- -------------------------------------

solution2 :: [Integer] -> Integer
solution2 list = sum $ map fuelPerMassRecursive list



