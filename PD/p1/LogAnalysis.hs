{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where
import Log

getNum :: MaybeInt -> Int
getNum (ValidInt num) = num

-- Punto 1
parseMessage :: String -> MaybeLogMessage
parseMessage msg
    | ((head msg) == 'I') = getNum (readInt ((words msg)!!1))
    | otherwise = 0