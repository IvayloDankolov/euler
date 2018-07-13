module Utils (subsequencesOfSize, sublistsOfSize) where

subsequencesOfSize :: Int -> [a] -> [[a]]
subsequencesOfSize n xs = let l = length xs
                          in if n>l then [] else subsequencesBySize xs !! (l-n)
 where
   subsequencesBySize [] = [[[]]]
   subsequencesBySize (x:xs) = let next = subsequencesBySize xs
                             in zipWith (++) ([]:next) (map (map (x:)) next ++ [[]])


sublistsOfSize :: Int -> [a] -> [[a]]
sublistsOfSize 0 _ = [[]]
sublistsOfSize n xs 
    | length xs < n = []
    | otherwise     = sublistIterator (fst splits) (snd splits)
    where
        splits = splitAt n xs
        sublistIterator curr [] = [curr]
        sublistIterator curr (x:xs) = curr : sublistIterator (tail curr ++ [x]) xs