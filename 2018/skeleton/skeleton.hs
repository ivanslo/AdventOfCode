
-- Data.Char is for 'isDigit' function
import Data.Char

main = do
    input <- getContents
    print("- Part 1 ")
    print( solution1 ( input ) )
    print("- Part 2 " )
    print( solution2 ( input ) )

solution1 x = x
solution2 x = x
