{- pi(x) <= x / logx (1 + 1.2762 / logx)

x / logx (1 + 1.2762 / logx) = n


1 2 3 4 5 6 7 8 9 10 11 12 13 14

235 wheel

0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
  *           *        *      *          *     *           *                  *

 1 : 6 : 4 : 2 : 4 : 2 : 4 : 6 : 2 : 6 : ...

 wheel5 = 6 : 4 : 2 : 4 : 2 : 4 : 6 : 2 : wheel5

-}

import Math.NumberTheory.Primes.Counting
main = print $ nthPrime 10001