import Math.NumberTheory.Primes.Factorisation

factorCounts = (map snd).factorise
numDivisors = product.(map (+1)).factorCounts

triangleNumbers = scanl (+) 1 [2..]


firstWithNDivisors:: Int -> [Integer] -> Integer
firstWithNDivisors n nums = head $ dropWhile (\x -> numDivisors x < n) nums 

main = putStrLn $ show $ firstWithNDivisors 500 triangleNumbers