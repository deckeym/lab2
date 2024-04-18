import Data.List (foldl')

reglamentCheck :: Int -> Bool
reglamentCheck num = go (num `div` 10) (num `mod` 10)
  where
    go 0 _ = True
    go n prevDigit
      | currentDigit <= prevDigit = go (n `div` 10) currentDigit
      | otherwise = False
      where
        currentDigit = n `mod` 10

numReverser :: Int -> Int
numReverser numBlank
  | reglamentCheck numBlank = go numBlank 0
  | otherwise = 0
  where
    go 0 reversedNum = reversedNum
    go n reversedNum = go (n `div` 10) (reversedNum * 10 + n `mod` 10)

main :: IO ()
main = do
  let numbers = [1234, 5678, 9012, 3456]
  let reversedNumbers = map numReverser numbers
  putStrLn $ unwords $ map show reversedNumbers