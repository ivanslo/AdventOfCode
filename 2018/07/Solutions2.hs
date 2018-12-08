
module Solutions2(
    solution1,
    solution2
) where

import Debug.Trace
import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Char
import Data.Either
import Data.List
import Data.Char

-- enable/disable debugging
trace' :: String -> a -> a
trace' s a = trace s a
-- trace' s a = a
type Connection = (Char, Char)

-- SOLUTION 1

solution1 :: [String] -> String
-- solution1 list = concat $ map rmdups $ makeLists [] $ rights $ map parseInput list
solution1 list = solve1 $ rights $ map parseInput list


solve1 :: [Connection] -> String
solve1 conns =
    let nodes = getNodes conns
        ss = executeStep nodes ""  conns
    in ss
    -- in trace'(ss ++ " -- " ++ show nodes) ""

-- recursive step execution
-- 1) get all states which are ready (not present in the second member)
-- 2) sort them
-- 3) pick first: consume it (remove from connections)
-- 4) return the consumed -- recurse 
-- termination: when there's only one in nodes, return that one
-- note: at returning in (1) and (4), we concatenate
executeStep :: String -> String -> [Connection] -> String
executeStep [n]   [] conns = [n]
executeStep nodes readies conns =
    let (r:rs) = sort $ readies ++ getNewReadies nodes conns 
        conns' = consumeConnections r conns
        nodes' = filterChars nodes (r:rs)
        
    in (r:(executeStep nodes' rs conns'))
    -- in trace'(" -- " ++ show (r:rs) ++ show nodes' ++ show conns') (r:(executeStep nodes' rs conns'))

consumeConnections :: Char -> [Connection] -> [Connection]
consumeConnections c conns = filter (\x -> (fst x) /= c) conns

getNewReadies :: String -> [Connection] -> String
getNewReadies nodes conns = 
    let seconds = foldl (\acc x -> acc++[snd x]) "" conns
    in  filterChars nodes seconds

filterChars :: String -> String -> String
filterChars word flt = filter (\x -> not (x `elem` flt)) word

getNodes :: [Connection] -> String
getNodes conns = rmdups $ foldl (\acc x -> acc ++ [fst x] ++ [snd x]) "" conns


rmdups :: (Ord a) => [a] -> [a]
rmdups = map head . group . sort

parseEdge :: Parsec String () (Char, Char)
parseEdge = do
  _ <- string "Step "
  x <- anyChar
  _ <- string " must be finished before step "
  y <- anyChar
  string " can begin."
  spaces
  return (x, y)

parseInput :: String -> Either ParseError (Char, Char)
parseInput = parse parseEdge ""


--- SOLUTION 2

data Conn = Conn 
    { from :: Char
    , to :: Char
    , time :: Int} 

instance Show Conn where  
    show x = [from x] ++ "->" ++ [to x] ++ "_("++ (show $ time x )++ ") "

parseEdgeWTime :: Parsec String () Conn
parseEdgeWTime = do
  _ <- string "Step "
  x <- anyChar
  _ <- string " must be finished before step "
  y <- anyChar
  string " can begin."
  spaces
  return (Conn x y (getTime x))

parseInputWTime :: String -> Either ParseError Conn
parseInputWTime = parse parseEdgeWTime ""

solution2 :: [String] -> String
solution2 list = solve2 $ rights $ map parseInputWTime list

getTime :: Char -> Int
getTime c = ord c - ord 'A' + 61


getNodesWTime :: [Conn] -> String
getNodesWTime conns = rmdups $ foldl (\acc x -> acc ++ [from x] ++ [to x]) "" conns

solve2 :: [Conn] -> String
solve2 conns =
    let nodes = getNodesWTime conns
        ss = executeStepWTime 0 nodes "" "" conns
    in trace'(show conns) ss

-- recursive step execution
-- 1) get all states which are ready (not present in the second member)
-- 2) sort them
-- 3) pick first: consume it (remove from connections)
-- 4) return the consumed -- recurse 
-- termination: when there's only one in nodes, return that one
-- note: at returning in (1) and (4), we concatenate
executeStepWTime :: Int -> String -> String -> String -> [Conn] -> String
executeStepWTime t [n]   _ _ [] = show $ (getTime n) + t
executeStepWTime t nodes readies workin conns =
    let rs = rmdups $ getNewReadiesWTime nodes conns 
        -- working = workin ++ (take (2 - (length workin)) (r:rs))
        working = getNewWorkers workin (rs)
        workers = map performWork working
        conns' = applyWorkers workers conns
        conns'' = consumeConnectionsWTime conns'
        consumedNodes = rmdups $ foldl (\acc x -> acc ++ (if time x == 0 then [from x] else "")) "" conns'
        working' = filterChars working consumedNodes
        nodes' = filterChars nodes (consumedNodes)
        
    -- in if t > 50 then "" else trace'("---- ++ t: "++ show t ++"\nNodes in " ++ show (rs) ++ "\n unworked: " ++ show conns ++ "\n worked  : " ++ show conns' ++ "\n filtered: " ++ show conns'' ++ "\n consumed: " ++ consumedNodes ++ "\n workers  :" ++ working' )
    in ((executeStepWTime (t+1) nodes' rs working' conns'')) 

consumeConnectionsWTime :: [Conn] -> [Conn]
consumeConnectionsWTime conns = filter (\x -> (time x) /= 0) conns

getNewWorkers :: String -> String -> String
getNewWorkers wng rds = 
    let readies = filterChars rds wng
        wN = length wng
    in wng ++ take (5 - wN) readies

performWork :: Char -> Conn -> Conn
performWork c conn = if c == (from conn) 
                    then Conn (from conn) (to conn) ((time conn) - 1)
                    else conn

applyWorkers :: [(Conn -> Conn)] -> [Conn] -> [Conn]
applyWorkers [] conns = conns
applyWorkers (w:ws) conns = map w (applyWorkers ws conns)

getNewReadiesWTime :: String -> [Conn] -> String
getNewReadiesWTime nodes conns = 
    let seconds = foldl (\acc x -> acc++[to x]) "" conns
    in  filterChars nodes seconds
