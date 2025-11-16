import Utils
import Data.List (sort)
import Data.Maybe (mapMaybe)
{-

Since we do have to perform at least 2 multiplications,
the largest number we have to check is 9999  (4 digits + 5 digits = 9 digits)
Anything above blows past 9 digits.

-}

nDigitProduct :: Int -> Int -> Maybe [Int]
nDigitProduct n x = collect 1 []
    where
        collect i res
            | length res > n = Nothing
            | length res == n = Just res
            | otherwise = collect (i+1) (res ++ digits (i*x))

isPandigital:: [Int] -> Bool
isPandigital xs = length xs == 9 && sort xs == [1..9]

-- It's remarkable how Haskell makes even the worst brute force
-- seem like an elegant tool from a more civilized age.

allPandigitalProducts :: [Int] -> [Int]
allPandigitalProducts =
    map fromDigits
    . filter isPandigital
    . mapMaybe (nDigitProduct 9)

main :: IO ()
main = print $ maximum $ allPandigitalProducts [1..9999]