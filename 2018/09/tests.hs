-- Test Cases
--
-- Problem 1
-- 10 players; last marble is worth 1618 points: high score is 8317
-- 13 players; last marble is worth 7999 points: high score is 146373
-- 17 players; last marble is worth 1104 points: high score is 2764
-- 21 players; last marble is worth 6111 points: high score is 54718
-- 30 players; last marble is worth 5807 points: high score is 37305
--
-- Problem 2
--

import Text.Printf
import Solutions

main = do
    input <- getContents
    print("Problem 1")
    test_case 32 (solution1Seq 9 25)
    test_case 8317 (solution1Seq 10 1618)
    test_case 146373 (solution1Seq 13 7999)
    test_case 2764 (solution1Seq 17 1104)
    test_case 54718 (solution1Seq 21 6111)
    test_case 37305 (solution1Seq 30 5807)
    print("Problem 2")
    test_case 0 0
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Int) (r :: Int)
    
