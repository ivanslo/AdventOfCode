module Solutions(
    solution1,
    solution2
) where

import Debug.Trace

-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


runPhase :: [Int] -> [Int]
runPhase signal = map (calcNumber signal) [1..d]
    where d = length signal


calcNumber :: [Int] -> Int -> Int
calcNumber signal iter =
    let suma = sum $ zipWith (*) signal (getPattern iter)
    in abs(suma) `mod` 10


getPattern :: Int-> [Int]
getPattern n = tail $ concat $ repeat $ concat $ map (replicate n) [0,1,0,-1]


runPhases :: Int -> [Int] -> [Int]
runPhases 0 signal = signal
runPhases n signal = trace'("" ++ (show signalOutput)) runPhases (n-1) signalOutput
    where signalOutput = runPhase signal
    


processStringAndTrigger :: String -> Int -> [Int]
processStringAndTrigger signal times =  runPhases times $ map (read . (:[])) signal

-- ----------------------------- 
-- SOLUTION 1
solution1 :: String -> String
solution1 list = concat $ map show $ processStringAndTrigger list 100

-- ----------------------------- 
-- SOLUTION 2 -- INCOMPLETE
solution2 :: String -> String
solution2 list = 
    let finalSignal = concat $ map show $ processStringAndTrigger (concat $ replicate 10000 list) 100
        nToIgnore = read (take 7 list) ::Int
    in take 8 $ drop nToIgnore $ finalSignal
