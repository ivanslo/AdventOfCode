module Solutions(
    solution1,
    solution2
) where

import Debug.Trace
import Data.List
import Data.List.Split
import Text.Regex.Posix


-- enable/disable debugging
trace' :: String -> a -> a
-- trace' s a = trace s a
trace' s a = a


-- ----------------------------- 
-- SOLUTION 1
solution1 :: [String] -> Int
solution1 xs = 
    let passports = map (concat . (intersperse " ")) $ splitWhen (=="") xs
    in  validPassports passports


validPassports :: [String] -> Int
validPassports [] = 0
validPassports (x:xs)
    | hasValidFields x == True = 1 + validPassports xs
    | otherwise = validPassports xs


hasValidFields :: String -> Bool
hasValidFields s = 
    let hasByr = s =~ "byr:" :: Bool
        hasIyr = s =~ "iyr:" :: Bool
        hasEyr = s =~ "eyr:" :: Bool
        hasHgt = s =~ "hgt:" :: Bool
        hasHcl = s =~ "hcl:" :: Bool
        hasEcl = s =~ "ecl:" :: Bool
        hasPid = s =~ "pid:" :: Bool
        hasCid = s =~ "cid:" :: Bool
    in hasByr && hasIyr && hasEyr && hasHgt && hasHcl && hasEcl && hasPid


-- ----------------------------- 
-- SOLUTION 2
solution2 :: [String] -> Int
solution2 xs = 
    let passports = map ( (++" ") . concat . (intersperse " ")) $ splitWhen (=="") xs
    in validPassports' passports

validPassports' :: [String] -> Int
validPassports' [] = 0
validPassports' (x:xs)
    | (hasValidFields x && fieldsAreValid x) == True = 1 + validPassports' xs
    | otherwise = validPassports' xs

fieldsAreValid :: String -> Bool
fieldsAreValid s =
    let tests = map (\f -> f s) [byrOk, iyrOk, eyrOk, hgtOk, hclOk, eclOk, pidOk, cidOk]
    in all (==True) tests

byrOk :: String -> Bool
byrOk s 
    | year >= 1920 && year <= 2002 = True
    | otherwise = False
    where   (_, _, _,[yearS]) = s =~ "byr:([0-9]+)" :: (String, String, String, [String])
            year = read yearS :: Int

iyrOk :: String -> Bool
iyrOk s 
    | year >= 2010 && year <= 2020 = True
    | otherwise = False
    where   (_, _, _,[yearS]) = s =~ "iyr:([0-9]+)" :: (String, String, String, [String])
            year = read yearS :: Int

eyrOk :: String -> Bool
eyrOk s = 
    let (_, _, _,[yearS]) = s =~ "eyr:([0-9]+)" :: (String, String, String, [String])
        year = read yearS :: Int
    in year >= 2020 && year <= 2030 

hgtOk :: String -> Bool
hgtOk s =
    let (_, _, _, [heightS, dim]) = s =~ "hgt:([0-9]+)(cm|in)?" :: (String, String, String, [String])
        height = read heightS :: Int
    in validateHeight height dim

validateHeight :: Int -> String -> Bool
validateHeight h "in" = h >= 59 && h <= 76
validateHeight h "cm" = h >= 150 && h <= 193
validateHeight h _ = False


hclOk :: String -> Bool
hclOk s = s =~ "hcl:#([0-9]|[a-f]){6} " :: Bool

eclOk :: String -> Bool
eclOk s = s =~ "ecl:(amb|blu|brn|gry|grn|hzl|oth) " :: Bool

pidOk :: String -> Bool
pidOk s = s =~ "pid:([0-9]){9} " :: Bool

cidOk :: String -> Bool
cidOk s = True

