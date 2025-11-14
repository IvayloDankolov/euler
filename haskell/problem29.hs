import Data.Set (Set, fromList, fromAscList)
import Data.List
{-
Could we easily brute force this? Sure, there's like 10k powers.

Let's explore what it would mean for two powers to be identical though:

a^b = c^d for some integers a, b, c, d
Also, a != c and b != d (if they are, the only solution is a=c and b=d)

log(a^b) = log(c^d)
b * log(a) = d * log(c)
b = d * log(c) / log(a)

Now, there's two possibilities for this to result in an integer solution:
1. both log(c) and log(a) have to be rational

Since the log base is arbitray, we can just pick ln and integers could never be powers of e, so this is impossible.

2. log(c) and log(d) are multiples of the same irrational number. Let's assume:

log(c) = m * k
log(a) = n * k

where k is irrational and m, n are integers.

That means:

log(c) / m = k
l9g(c ^ (1/m)) = k
log(a ^ (1/n)) = k

c ^ (1/m) = a ^ (1/n)
c = a ^ (m/n)

So a and c have to be powers of the same base, since a,c,m and n are all integers


Therefore, the only possible duplicates in this list would be grouped by base powers.

2, 4, 8, 16, 32, 64
3, 9, 27, 81
5, 25
6, 36
7, 49
8, 64
9, 81
10, 100

And this becomes a combinatorial problem

For the groups of 2 this is easy, since are powers are also limited from 2 to 100. E.g:
100 ^ 2 = 10 ^ 4
100 ^ 3 = 10 ^ 6
...
100 ^ 50 = 10 ^ 100

So we have 49 duplicates for each of 5, 6, 7, 8, 9, 10
Which is (100 - 2) / 2, if we express it as (maxPow - minPow) / baseDifference

When you involve 2 and 3, you'll get a bit of a 
combinatorial explosion though. For the case of multiple overlapping powers, 
we have the extraproblem of overcounting if we were to just go down recursively

So it's not enough to just write a function that counts duplicates 
between two base multiples

How do we extend it to 3,4,etc base multiples and count 
only the shared ones simultaneously between e.g. 3 bases?
We would need that to use inclusion-exclusion principle since we need to
add up all pairwise duplicates, subtract triple-wise duplicates, 
add quadruple-wise duplicates, etc.

At that point, we've overcomplicated this so much that we might as well
just make a set of all the powers, it won't be any slower
-}

powerSet:: Integer -> Integer -> Integer -> Integer -> Set Integer
powerSet minBase maxBase minPow maxPow =
    fromList [b ^ p | b <- [minBase..maxBase], p <- [minPow..maxPow]]


main :: IO ()
main = print $ length $ powerSet 2 100 2 100