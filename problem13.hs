-- Misread the statement initially (to last 10 digits), leaving functions for later reference

leave:: Int -> [a] -> [a]
leave n xs = drop (max 0 (length xs - n)) xs

lastNDigitSum:: Int -> [String] -> String
lastNDigitSum n = (leave n) . show . sum . map (read . leave n)

main = do
    t <- readFile "problem13.in"
    putStrLn $ take 10 $ show $ sum $ map (\x -> read x :: Integer) $ lines t