{-

Now, let's observe a 5 by 5 spiral:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

Now, it's pretty clear that the top right diagonal is just n^2

And an entire layer is:
n^2 + n^2 - n + 1 + n^2 - 2n + 2 + n^2 - 3n + 3 = 4n^2 - 6n + 6

So we just need to sum that for n = 3, 5, 7, ..., 1001

And we don't bother generating the entire spiral.

Figuring out the cubic formula equivalent for this is left as an exercise to the reader.
-}

spiralSum :: Integral a => a -> a
spiralSum 1 = 1
spiralSum n = spiralSum (n - 2) + 4 * n * n - 6 * n + 6


main :: IO ()
main = print $ spiralSum 1001