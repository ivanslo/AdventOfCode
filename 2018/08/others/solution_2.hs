import qualified Text.Parsec     as P

type Parser = P.Parsec [Int] ()

sum1 :: Parser Int
sum1 = do
    numChild <- P.anyToken
    numMeta  <- P.anyToken
    childs   <- sum <$> replicateM numChild sum1
    metas    <- sum <$> replicateM numMeta  P.anyToken
    pure $ childs + metas

day08a :: [Int] -> Int
day08a = fromRight 0 . P.parse sum1 ""


-- part 2

sum2 :: Parser Int
sum2 = do
    numChild <- P.anyToken
    numMeta  <- P.anyToken
    childs   <- replicateM numChild sum2
    metas    <- replicateM numMeta  P.anyToken
    pure $ if null childs
      then sum metas
      else sum . mapMaybe (\i -> childs ^? ix (i - 1)) $ metas

day08a :: [Int] -> Int
day08a = fromRight 0 . P.parse sum2 ""
