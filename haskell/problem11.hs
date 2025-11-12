import Data.List.Split
import Data.Matrix
import Data.List
import qualified Data.Vector as V
import Utils

lists:: String -> [[Int]]
lists text = map (map read . splitOn " ") $ lines text

rowDiag:: Matrix a -> Int -> [a]
rowDiag m i = map (\(i,j) -> getElem i j m) $ map (\k -> (i+k, 1+k)) [0..(nrows m)-i]

rowDiagReverse:: Matrix a -> Int -> [a]
rowDiagReverse m i = map (\(i,j) -> getElem i j m) $ map (\k -> (i+k, nr-k)) [0..nr-i]
    where
        nr = nrows m

colDiag:: Matrix a -> Int -> [a]
colDiag m i = map (\(i,j) -> getElem i j m) $ map (\k -> (1+k, i+k)) [0..(ncols m)-i]

colDiagReverse:: Matrix a -> Int -> [a]
colDiagReverse m i = map (\(i,j) -> getElem i j m) $ map (\k -> (nc-i-k, i+k)) [0..nc-i-1]
    where
        nc = ncols m

rowDiags:: Matrix a -> [[a]]
rowDiags m = map (rowDiag m) [1..nrows m]

colDiags:: Matrix a -> [[a]]
colDiags m = map (colDiag m) [1..ncols m]

rowDiagsReverse:: Matrix a -> [[a]]
rowDiagsReverse m = map (rowDiagReverse m) [1..nrows m]

colDiagsReverse:: Matrix a -> [[a]]
colDiagsReverse m = map (colDiagReverse m) [1..ncols m]

rows:: Matrix a -> [[a]]
rows m = map (\i -> V.toList $ getRow i m) [1..nrows m]

cols:: Matrix a -> [[a]]
cols m = map (\i -> V.toList $ getCol i m) [1..ncols m]

allSequences:: Matrix a -> [[a]]
allSequences m = concat [rows m, cols m, rowDiags m, colDiags m, rowDiagsReverse m, colDiagsReverse m]

sublistProductsOfSize:: Num a => Int -> [a] -> [a]
sublistProductsOfSize n nums = map (foldl (*) 1) $ sublistsOfSize n nums

largestMatrixSubsequenceProductOfSize:: (Num a, Ord a) => Int -> Matrix a -> a
largestMatrixSubsequenceProductOfSize n mat = maximum $ concat $ map (sublistProductsOfSize n) $ allSequences mat

main = do
    text <- readFile "problem11.in"
    let matrix = fromLists $ lists text in do
        putStrLn $ show $ largestMatrixSubsequenceProductOfSize 4 matrix