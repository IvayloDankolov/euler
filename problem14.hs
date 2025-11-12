import Data.Function (on)
import Data.List (maximumBy)

takeWhileInclusive :: (a -> Bool) -> [a] -> [a]
takeWhileInclusive _ [] = []
takeWhileInclusive p (x:xs) = x : if p x then takeWhileInclusive p xs
                                         else []

collatzStep:: Integral a => a -> a
collatzStep n
    | odd n     = 3 * n + 1
    | otherwise = n `div` 2

collatzSeq:: Integral a => a -> [a]
collatzSeq = takeWhileInclusive (/= 1) . iterate collatzStep

largestCollatz:: Int -> Int
largestCollatz n = maximumBy (compare `on` (length.collatzSeq)) [1..n]

main = putStrLn $ show $ largestCollatz 1000000