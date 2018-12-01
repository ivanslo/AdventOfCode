-- Test Cases
--
-- Problem 1
-- +1, +1, +1 results in  3
-- +1, +1, -2 results in  0
-- -1, -2, -3 results in -6
--
-- Problem 2
-- +1, -1 first reaches 0 twice.
-- +3, +3, +4, -2, -4 first reaches 10 twice.
-- -6, +3, +8, +5, -6 first reaches 5 twice.
-- +7, +7, -2, -7, -4 first reaches 14 twice.

import Text.Printf
import Solutions

main = do
    print("Problem 1")
    test_case 3     (solution1 [1, 1, 1]) 
    test_case (0 )  (solution1 [1, 1, -2])
    test_case (-6)  (solution1 [-1, -2, -3])
    print("Problem 2")
    test_case 0     (solution2 [1, -1])
    test_case 10    (solution2 [3, 3, 4, -2, -4])
    test_case 5     (solution2 [-6, 3, 8, 5, -6])
    test_case 14    (solution2 [7, 7, -2, -7, -4])
    return ()


test_case e r = 
    printf " [%s] - expects %d and returned %d\n" (show (e == r) :: String)  (e :: Integer) (r :: Integer)
    
