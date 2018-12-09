import Data.Tree
import Data.Attoparsec.Text
import qualified Data.Text.IO as T

main :: IO ()
main = do
  contents <- T.readFile "08.txt"
  let Right t = parseOnly parseTree contents
  print . sum   $ sum <$> t
  print . value $ t

value :: Tree [Int] -> Int
value (Node metadata []) = sum metadata
value (Node metadata children) =
  sum [ maybe 0 value (children !? (i - 1)) | i <- metadata ]

parseTree :: Parser (Tree [Int])
parseTree = do
  numChildren <- decimal <* space
  numMetadata <- decimal <* space
  children    <- count numChildren parseTree
  metadata    <- count numMetadata (decimal <* option ' ' space)
  return (Node metadata children)

(!?) :: [a] -> Int -> Maybe a
(!?) list i
  | i >= length list || i < 0 = Nothing
  | otherwise                 = Just (list !! i)
