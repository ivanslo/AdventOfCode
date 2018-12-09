module Solutions(
    solution1,
    solution1Seq,
    solution2
) where

import Debug.Trace
import qualified Data.Sequence as Seq

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a


solution1 :: Int {- ^ players -} -> Int -> Int
solution1 players lastMarble =
    let points = play lastMarble players 2 [0,2,1] 1 3 (replicate players 0)
        biggest = maximum points
        elfNr = 1 + (length $ takeWhile (/=biggest) points)
    in  trace'(" Biggest: " ++ (show biggest) ++ "\n By: " ++ (show elfNr)) biggest

play :: Int -> Int -> Int -> [Int] -> Int -> Int -> [Int] -> [Int]
play maxMarble maxPlayers pl marbles sel next scores = 
    if (mod next 23) == 0 then 
        -- let scores' = addScore (pl+1) next
        let newPos = goback7 sel (length marbles)
            element = marbles !! newPos
            scores' = addScores scores pl (element + next)
            marbles' = removeFromMarble newPos marbles
        in play maxMarble maxPlayers (mod (pl+1) maxPlayers) marbles' newPos (next+1) scores'
    else
        let pos = mod (sel + 2) (length marbles)
            marbles' = modifyMarble marbles pos next
        in if next <= maxMarble then play maxMarble maxPlayers (mod (pl+1) maxPlayers) marbles' pos (next+1) scores
        -- in if next <= maxMarble then trace'(" ["++ show (pl+1) ++" ] " ++(show $ marbles') ++ " - " ++ (show pos) ++ " - added "
        -- ++ (show next))
            -- play maxMarble (mod (pl+1) 9) marbles' pos (next+1) scores
            else trace'("POINTS: " ++ (show scores)) scores

playSeq :: Int -> Int -> Int -> Seq.Seq Int  -> Int -> Int -> [Int] -> [Int]
playSeq maxMarble maxPlayers pl marbles sel next scores = 
    if (mod next 23) == 0 then 
        -- let scores' = addScore (pl+1) next
        let newPos = goback7 sel (length marbles)
            element = Seq.index marbles newPos
        --     element = marbles !! newPos
            scores' = addScores scores pl (element + next)
            marbles' = Seq.deleteAt newPos marbles
        in playSeq maxMarble maxPlayers (mod (pl+1) maxPlayers) marbles' newPos (next+1) scores'
    else
        let pos = mod (sel + 2) (length marbles)
            -- marbles' = modifyMarble marbles pos next
            marbles' = Seq.insertAt pos next marbles
        in if next <= maxMarble then 
            playSeq maxMarble maxPlayers (mod (pl+1) maxPlayers) marbles' pos (next+1) scores
            else scores

solution1Seq :: Int {- ^ players -} -> Int {- ^ lastMarble -} -> Int
solution1Seq players lastMarble =
    let table = Seq.insertAt 1 2 (Seq.insertAt 1 1 (Seq.singleton 0))
        points = trace'("tt" ++ show table) playSeq lastMarble players 2 table 1 3 (replicate players 0)
        biggest = maximum points
        elfNr = 1 + (length $ takeWhile (/=biggest) points)
    in  trace'(" Biggest: " ++ (show biggest) ++ "\n By: " ++ (show elfNr)) biggest

modifyMarble :: [Int] -> Int -> Int -> [Int]
modifyMarble ms 0 el = el:ms
modifyMarble (m:ms) p el = m:(modifyMarble ms (p-1) el)

goback7 :: Int -> Int -> Int
goback7 pos border
    | pos - 7 < 0 = border + (pos - 7)
    | otherwise   = pos - 7

solution2 :: [Int] -> Int
solution2 list = 0

addScores :: [Int] -> Int -> Int -> [Int]
addScores (s:sc) player points
    | player == 0   = (s+points):sc
    | otherwise     = s:(addScores sc (player-1) points)

removeFromMarble :: Int -> [Int] -> [Int]
removeFromMarble p (m:ms)
    | p == 0 = ms
    | otherwise = m:(removeFromMarble (p-1) ms)

