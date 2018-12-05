module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.Time
import Data.List
import Text.Regex

data Action = WakesUp | FallAsleep | BeginsShift deriving
            (Show, Read,Ord, Eq, Enum, Bounded)
data Entry = Entry
    { date :: UTCTime
    , action :: Action
    , guard :: Int
    }
    deriving (Show,Ord, Eq)

data Shift = Shift
    { guardnr :: Int
    , report :: [Bool]
    -- this will help to reduce
    , number :: Int
    , what :: Action
    }
    deriving (Show, Ord, Eq)

-- instance Ord Entry where
--     compare a b = compare (date a) (date b)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

entryFromString :: String -> Entry
entryFromString str = 
    let (Just matched) = matchRegex (mkRegex "\\[(.*)\\] (.*)" ) str
        (Just date) =  parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" (matched !! 0) :: Maybe UTCTime
        action = getActionFromStr (matched !! 1)
        guardNr = if action == BeginsShift then getNumberFromStr (matched !! 1) else 0
    in Entry date action guardNr
-- entryFromString = 
    -- where readEntry [date, action, guard] = Entry date action guard
getActionFromStr :: String -> Action
getActionFromStr str
    | letter == 'G' = BeginsShift
    | letter == 'f' = FallAsleep
    | letter == 'w' = WakesUp
    where letter = head str

getNumberFromStr :: String -> Int
getNumberFromStr str = 
    let (Just nrStr) = matchRegex (mkRegex "#(.*) begins") str
        nr = read (nrStr !! 0) :: Int
    in nr


solution1 :: [String] -> Integer
solution1 list = trace'(show $ getLists $ sort $ map entryFromString list) 0

getLists :: [Entry] -> [Shift]
getLists [] = []
getLists entries = foldl reducerFunction [] entries
-- getLists entries = foldl (\acc e -> reducerFunction acc e) [] entries
-- getLists (e:entries) 
--     | guard e /= 0 = ((guard e), vector60):(getLists entries)
--     | action e == FallAsleep && action next == WakesUp = (fst e, fillList (snd e) from to):(getLists entries)
--     ----- e is not. It should be the PREVIOUS LIST CREATED. F***
--     | otherwise = getLists entries
--     where next = head entries
--           from = getMinute (date e)
--           to = getMinute (date next)



reducerFunction :: [Shift] -> Entry -> [Shift]
reducerFunction acc entry
    | guardNr /= 0  = (Shift guardNr  vector60 0 act):(acc)
    | otherwise     = acc
    where guardNr = guard entry
          act = action entry
-- reducerFunction acc e = ((0,[True])):acc
-- reducerFunction acc e 
--         |
--         where currenDay = head acc

vector60 = replicate 60 False

getMinute :: UTCTime -> Int
getMinute date = floor $ toRational $ utctDayTime date / 60

solution2 :: [String] -> Integer
solution2 list = 0

fillList :: [Bool] -> Int -> Int  -> [Bool]
fillList [] _ _ = []
fillList (x:xs) from to
    | from > 0 = x:(fillList xs (from-1) to)
    | to > 0 = True:(fillList xs 0 (to-1))
    | otherwise  = x:xs
-- fillList vector entry = 
