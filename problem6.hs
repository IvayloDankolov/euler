{-
ab + ac + ad + bc + bd + cd

ab + ac + bc + d * (a + b + c)
ab + c * (a + b) + d * (a + b + c)

b * (a) + c * (a + b) + d * (a + b + c)

sum(i in [2, n], i * sum(j in [1, i-1], j))
sum(i in [2, n], i * i * (i-1) / 2)

-}

square_diff n = sum $ map (\i -> i * i * (i - 1)) [2..n] 

main = print $ square_diff 100