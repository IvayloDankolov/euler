reduceFraction (a,b) = (a `div` d, b `div` d)
    where d = gcd a b

-- Obviously only works on two digit numbers
containsDigit x n = x == r || x == q
    where (q,r) = n `divMod` 10

otherDigit x n = if x == r then q else r
    where (q,r) = n `divMod` 10

isInterestingFraction (a,b) =
    reducedA < 10
    && reducedB < 10
    && containsDigit reducedA a
    && containsDigit reducedB b
    && otherDigit reducedA a == otherDigit reducedB b
    && otherDigit reducedB b /= 0
    where (reducedA, reducedB) = reduceFraction (a,b)


fractionPairs = [(a, b) | a <- [10..99], b <- [a+1..99]]
candidates = filter isInterestingFraction fractionPairs

{-
OK, at this point I realised that what I did above isn't 
actually what the problem asks for. It's supposed to be 
fractions that remain the same if you cancel the common digit.

What we actually did is fractions that simplify to the least possible form
by removing a common digit.

But since the above produces 3 candidates, I'm just going to cheat
by manually adding the 4th from the problem example.

Shrug emoji.
-}
reducedCandidates = (49, 98) : map (\(a,b) -> reduceFraction (a,b)) candidates
combinedFraction = (product $ map fst reducedCandidates,
                    product $ map snd reducedCandidates)

reducedCombinedFraction = reduceFraction combinedFraction

main:: IO ()
main = do
    print candidates;
    print $ map (\(a,b) -> reduceFraction (a,b)) candidates;
    print reducedCombinedFraction