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
    deriving ( Ord, Eq)

instance Show Shift where
    show s = show (guardnr s) ++ " - " ++ showReport( report s ) ++ "\n"

showReport :: [Bool] -> String
showReport [] = ""
showReport (b:bs)
    | b = 'x':showReport(bs)
    | not b= '.':showReport(bs)

-- instance Ord Entry where
--     compare a b = compare (date a) (date b)

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a

-- PARSING INPUT
entryFromString :: String -> Entry
entryFromString str = 
    let (Just matched) = matchRegex (mkRegex "\\[(.*)\\] (.*)" ) str
        (Just date) =  parseTimeM True defaultTimeLocale "%Y-%m-%d %H:%M" (matched !! 0) :: Maybe UTCTime
        action = getActionFromStr (matched !! 1)
        guardNr = if action == BeginsShift then getNumberFromStr (matched !! 1) else 0
    in Entry date action guardNr

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

vector60 :: [Bool]
vector60 = replicate 60 False

getMinute :: UTCTime -> Int
getMinute date = floor $ toRational $ utctDayTime date / 60

-- SOLUTION 1

solution1 :: [String] -> Int
solution1 list = 
        let entries = reverse $ getShifts $ sort $ map entryFromString list
            sleeper = getBiggestSleeper entries
            minute  = getMinuteMostAsleep $ filter (\x -> guardnr x == sleeper) entries
        in sleeper * minute
        -- in trace'((show $ entries) ++ 
        -- in trace'(
        --     "\n Bigger Sleeper: " ++ (show $ sleeper) ++
        --     "\n Magic Minute  : " ++ (show $ minute )) 0
            

getMinuteMostAsleep :: [Shift] -> Int
getMinuteMostAsleep shifts = 
        let reports = map (report) shifts
            -- final = foldl1 (\a b -> zipWith (&&) a b) reports
            -- minut = length $ takeWhile (/=True) final
            histogram =  foldl (addTrues) (replicate 60 0) reports
            biggest =  maximum histogram
            pos = length $ takeWhile (/=biggest) histogram
        in pos

addTrues :: [Int] -> [Bool] -> [Int]
addTrues [] [] = []
addTrues (i:is) (b:bs)
    | b == True = (i+1):(addTrues is bs)
    | b == False = (i):(addTrues is bs)


getBiggestSleeper :: [Shift] -> Int
getBiggestSleeper shift = 
        let grouped = (groupPerGuard . sortPerGuard) shift
            ss = map minsAsleep grouped
            grds = map (guardnr . head) grouped
            min_guard = (reverse . sort ) $ zipWith (,) ss grds
        in snd (head min_guard) 

minsAsleep :: [Shift] -> Int
minsAsleep [] = 0
minsAsleep (s:ss) = (length $ filter (==True) (report s) )+ minsAsleep ss
                

groupPerGuard :: [Shift] -> [[Shift]]
groupPerGuard = groupBy (\x y -> guardnr x == guardnr y) 

sortPerGuard :: [Shift] -> [Shift]
sortPerGuard = sortBy (\x y -> compare (guardnr x) (guardnr y)) 

getShifts :: [Entry] -> [Shift]
getShifts [] = []
getShifts entries = foldl reducerFunction [] entries

reducerFunction :: [Shift] -> Entry -> [Shift]
reducerFunction [] entry = [Shift (guard entry) vector60 0 (action entry)]
reducerFunction (a:acc) e
    | (guard e) /= 0  = (Shift (guard e)  vector60 0 (action e)):(a:acc)
    | (action e) == FallAsleep = (Shift (guardnr a) (report a) (minute) FallAsleep):acc
    | (action e) == WakesUp = (Shift (guardnr a) tunedReport (minute) WakesUp):acc
    | otherwise =  (a:acc)
    where minute = getMinute $ date e
          tunedReport = fillList (report a) (number a) minute

fillList :: [Bool] -> Int -> Int  -> [Bool]
fillList [] _ _ = []
fillList (x:xs) from to
    | from > 0 = x:(fillList xs (from-1) (to-1))
    | to > 0 = True:(fillList xs 0 (to-1))
    | otherwise  = x:xs

-- SOLUTION 2

solution2 :: [String] -> Int
solution2 list = 
        let entries = reverse $ getShifts $ sort $ map entryFromString list
            grouped = (groupPerGuard . sortPerGuard) entries
            histogram = map histogramAsleep grouped
            grds = map (guardnr . head) grouped
            hist_guard = zipWith (,) grds histogram
            sleeper_hist = getGuardWithBiggestMinuteAslept hist_guard
            sleeper = fst sleeper_hist
            biggest = maximum (snd sleeper_hist)
            minute = length $ takeWhile (/=biggest) (snd sleeper_hist)
            -- minute  = getMinuteMostAsleep $ filter (\x -> guardnr x == sleeper) entries
        in trace'(show sleeper)
            sleeper * minute

getGuardWithBiggestMinuteAslept :: [(Int, [Int])] -> (Int, [Int])
getGuardWithBiggestMinuteAslept hs = foldl1 compareMaxMin  hs

compareMaxMin :: (Int, [Int]) -> (Int, [Int]) -> (Int, [Int])
compareMaxMin a b 
    | maximum (snd a) > maximum (snd b) = a
    | otherwise = b

histogramAsleep :: [Shift] -> [Int]
histogramAsleep rs = 
        let reports = map (report) rs
        in foldl (addTrues) (replicate 60 0) reports
