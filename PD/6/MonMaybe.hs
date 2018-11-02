module MonMaybe where

import Data.Monoid ( (<>) )
import Data.List
import Data.Maybe
import Text.Read

tieneBuenFormato :: String -> Bool
tieneBuenFormato = isJust . go
    where go :: String -> Maybe Int
          go (x1:x2:xs) = do
            let mNum = readMaybe x :: Maybe Int
            let num = fromJust mNum
            stripPrefix 