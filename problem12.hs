divisors n = filter (\x -> rem n x == 0) [1..n]
numDivisors = length.divisors

triangleNumber:: Integral a => Int -> a
triangleNumber 1 = 1
triangleNumber n = (fromIntegral n) + (triangleNumber (n-1))

triangleNumbers = map triangleNumber [1..]

firstWithNDivisors:: Integral a => Int -> [a] -> a
firstWithNDivisors n nums = head $ dropWhile (\x -> (length $ divisors x) < n) nums 

main = putStrLn $ show $ numDivisors (1*2*3*4*5)