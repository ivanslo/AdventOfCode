module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Time
import Text.Regex

data Action = WakesUp | FallAsleep | BeginsShift deriving
            (Show, Read, Eq, Enum, Bounded)
data Entry = Entry
    { date :: UTCTime
    , action :: Action
    , guard :: Int
    }
    deriving (Show, Eq)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

entryFromString :: String -> Entry
entryFromString str = 
    let (Just matched) = matchRegex (mkRegex "\\[(.*)\\]" ) str
        (Just date) =  parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" (matched !! 0) :: Maybe UTCTime
    in Entry date WakesUp 1
-- entryFromString = 
    -- where readEntry [date, action, guard] = Entry date action guard


solution1 :: [String] -> Integer
solution1 list = trace'(show $ map entryFromString list) 0

solution2 :: [String] -> Integer
solution2 list = 0


