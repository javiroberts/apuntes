{-# OPTIONS_GHC -Wall #-}
module Analyser where
import Log
import Data.List
import Data.Char

-- 1
getInt :: String -> Int
getInt str = getIntAux (readInt str)

getIntAux :: MaybeInt -> Int
getIntAux (ValidInt num) = num
getIntAux (InvalidInt) = undefined

parse :: String -> MaybeLogMessage
parse message = parseHelper (words message)

parseHelper :: [String] -> MaybeLogMessage
parseHelper [] = InvalidLM "wrong format"
parseHelper (x:xs)
        | x == "I" = infoMsg xs
        | x == "W" = warningMsg xs
        | x == "E" = errorMsg xs
        | otherwise =  InvalidLM "wrong format"

errorMsg :: [String] -> MaybeLogMessage
errorMsg (codeNum:orderNum:message)
            | (readInt codeNum) == InvalidInt || (readInt orderNum) == InvalidInt = InvalidLM "wrong format"
            | otherwise = ValidLM (LogMessage (Error (getInt codeNum)) (getInt orderNum) (unwords message))
errorMsg _ = InvalidLM "wrong format"

infoMsg :: [String] -> MaybeLogMessage
infoMsg (orderNum:message)
        | (readInt orderNum) == InvalidInt = InvalidLM "wrong format"
        | otherwise = ValidLM (LogMessage Info (getInt orderNum) (unwords message))
infoMsg _ = InvalidLM "wrong format"

warningMsg :: [String] -> MaybeLogMessage
warningMsg (orderNum:message)
        | (readInt orderNum) == InvalidInt = InvalidLM "wrong format"
        | otherwise = ValidLM (LogMessage Warning (getInt orderNum) (unwords message))
warningMsg _ = InvalidLM "wrong format"

-- 2
validMessageFilter :: [MaybeLogMessage] -> [LogMessage]
validMessageFilter messages = map msgFilter (filter validMessageHelper messages)

validMessageHelper :: MaybeLogMessage -> Bool
validMessageHelper (ValidLM _) = True
validMessageHelper (InvalidLM _) = False

msgFilter :: MaybeLogMessage -> LogMessage
msgFilter (ValidLM msg) = msg
msgFilter (InvalidLM _) = undefined

-- 3
parse :: String -> [LogMessage]
parse x = validMessageFilter (map parse (lines x))

-- 4
compareMessages :: LogMessage -> LogMessage -> Ordering
compareMessages (LogMessage _ time1 _) (LogMessage _ time2 _)
            | time1 < time2 = LT
            | time1 > time2 = GT
            | otherwise = EQ

-- 5
sortMessages :: [LogMessage] -> [LogMessage]
sortMessages x = sortBy compareMessages x

-- 6
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong [] = []
whatWentWrong ((LogMessage (Error errorNum) _ message): xs)
                                        | errorNum > 50 = [message] ++ (whatWentWrong xs)
                                        | otherwise = whatWentWrong xs
whatWentWrong (_:xs) = whatWentWrong xs

-- 7
messagePayload :: String -> [LogMessage] -> [LogMessage]
messagePayload keyword list = checkInner list keyword

checkInner :: [LogMessage] -> String -> [LogMessage]
checkInner [] _ = []
checkInner (x@(LogMessage _ _ msg):xs) keyword
                | length (x:xs) == 0 = []
                | (isInfixOf (map toLower keyword) (map toLower msg)) == True = [x] ++ checkInner xs keyword
                | otherwise = [] ++ checkInner xs keyword

-- 8
whatWentWrongEnhanced :: [Char] -> [LogMessage] -> [String]
whatWentWrongEnhanced keyword list = whatWentWrong (messagePayload keyword list)