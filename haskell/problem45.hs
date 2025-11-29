{-

--- Triangle vs pentagonal

n * (n+1) / 2 = k * (3k - 1) / 2
n^2 +n = 3k^2 - k
n^2 + n + k - 3k^2 = 0
D = 1 - 4k + 12k^2

Repeat

12k^2 - 4k + 1 = t^2
36k%2 - 12k + 3 = 3t^2
(6k -1)^2 = 3t^2 - 2

let x = 6k - 1

x^2 - 3t^2 = -2

OK, this is going to be some ungodly root of 3 formula when you
solve the Pell equation. And then you have this:

--- Hexagonal vs triangular

n * (n-1) /2 = a * (2a - 1)

n^2 + n = 4a^2 - 2a
n^2 + n + 2a - 4a^2 = 0
D = 1 - 8a + 16a^2
  = (4a - 1)^2

Huh, small blessing that that's a perfect square.

n = (-1 +- (4a - 1)) / 2 -- let's take only the positive root
n = (4a - 2) / 2
n = 2a - 1

Ah, so every hexagonal number is also triangular. 
Honestly that's pretty blindingl obvious but I tunnel visioned the pentagonal ones

Right, so we just solve the original Pell equation and filter to odd n's.

--- Back to P-hell

x^2 - 3t^2 = -2

Fortunately it's very obvious that x=1, t=1 is a solution.

Now back to the resolvent

x^2 - 3t^2 = 1

floor(sqrt(3)) = 1
r1 =  1 / (sqrt(3) - 1)
   = (sqrt(3) + 1) / ((sqrt(3) - 1) * (sqrt(3) + 1)) 
   = (sqrt(3) + 1) / 2
floor((sqrt(3) + 1) / 2) = 1
r2 = 1 / ((sqrt(3) +1) / 2 - 1)
   = 2 / (sqrt(3) - 1)
    = 2 * (sqrt(3) + 1) / ((sqrt(3) - 1) * (sqrt(3) + 1))
    = sqrt(3) + 1
floor(sqrt(3) + 1) = 2
r3 = 1 / (sqrt(3) + 1 - 2)
    = 1 / (sqrt(3) - 1)

Hello again r1

So, sqrt(3) = |1; 1,2,...|

Why did I not just put this in a calculator? Meh

The convergents are:

1/1, 2/1, 5/3

Therefor,

(u, v) = (h1, k1) = (2, 1)

So for the original equation:
x(0)=1, t(0)=1,
x(n+1) = 2x(n) + 3 * t(n)
y(n+1) = x(n) + 2 * t(n)


-- Let's recap where we are cause I sure as hell forgot

n^2 + n + k - 3k^2 = 0
D = 1 - 4k + 12k^2
let x = 6k - 1
x^2 - 3t^2 = -2

Let's unwind that x

k = (x + 1) / 6 where x = 5 (mod 6

n = ( -1 + sqrt(D) ) / 2 = ( -1 + t ) / 2 = (t -1) / 2

Where t is odd


Now I could make this a closed form by raising to a power, 
but honestly this will already be a clean enough Haskell solution

-}


pellSequence :: [(Integer, Integer)]
pellSequence = iterate next (1,1)
    where
        next (x, t) = (2*x + 3*t, x + 2*t)
validOriginalSolutions :: [(Integer, Integer)]
validOriginalSolutions = filter isValid pellSequence
    where
        isValid (x, t) = (x + 1) `mod` 6 == 0 && t `mod` 2 == 1
originalSequence :: [(Integer, Integer)]
originalSequence = map toOriginal validOriginalSolutions
    where
        toOriginal (x, t) = ( (t - 1) `div` 2 , (x + 1) `div` 6 )

triangleIndices = map fst originalSequence
validHexagonal = filter odd triangleIndices


triangle n = n * (n + 1) `div` 2
tripleNumbers = map triangle validHexagonal


targetSolution = 2

main :: IO ()
main = print $ tripleNumbers !! targetSolution

{-

It's honestly ironic how much math we did to get a solution that would 
be about the same amount of code in haskell as the brute force one.

This is so much more satisfying though. And as a bonus, we can do
take 1000 $ tripleNumbers and it gives you the next 1000 solutions
before you can blink.

Not even in the same universe of performance.

-}