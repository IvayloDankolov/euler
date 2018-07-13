{- a + b + c = 1000
c = sqrt(a^2 + b^2)

a + b + sqrt(a^2 + b^2) = 1000 integer solution
a + b + sqrt((a+b)^2 - 2ab) = 1000

a^2 + b^2 = (1000 - (a + b)) ^ 2 = 1e6 - 2000*(a+b) + (a+b)^2 =
	      = 1e6 - 2000*(a+b) + a^2 + 2ab + b^2


2ab + 1e6 = 2000*(a+b)

2000a + 2000b - 2ab = 1e6

a*(2000 - 2b) = 1e6 - 2000b

a = 1e6 - 2000b / (2000 - 2b) = 2000*(500 - b)/(2000 - 2b) = 1000 * (500 - b) / (1000 - b)

-}

import Data.List
import Data.Maybe

bs = filter (\b -> rem (1000*(500 - b)) (1000 - b) == 0) [1..999] 
as = map (\b -> 1000*(500 - b) `quot` (1000-b)) bs


(a, b) = fromJust $ find (\(a, b) -> a > 0 && b > 0 && a < b) $ zip as bs
c = floor $ sqrt $ fromIntegral (a^2 + b^2)

main = print (a*b*c)