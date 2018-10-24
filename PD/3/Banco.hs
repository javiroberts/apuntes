{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings, RecordWildCards #-}
module Banco where

import Data.ByteString.Lazy (ByteString)
import Data.Map.Strict (Map)
import Data.Bits (xor)
import Data.Maybe
import System.Environment (getArgs)

import qualified Data.ByteString.Lazy as BS
import qualified Data.Map.Strict as Map
import qualified Data.List as L

import Parser

-- 1
getSecret :: FilePath -> FilePath -> IO ByteString
getSecret file1 file2 = do 
                        content1 <- BS.readFile file1
                        content2 <- BS.readFile file2
                        return $ BS.pack $ filter (/= 0) $ BS.zipWith xor content1 content2

-- 2
decryptWithKey :: ByteString -> FilePath -> IO ()
decryptWithKey  key file = do
                           encryptedFile <- BS.readFile "victims.json.enc"
                           BS.writeFile file $ BS.pack $ BS.zipWith xor encryptedFile $ BS.cycle key
                           

-- 3
parseFile :: FromJSON a => FilePath -> IO (Maybe a)
parseFile filepath = do
                        jsonFile <- BS.readFile filepath
                        return $ decode jsonFile

-- 4
getBadTs :: FilePath -> FilePath -> IO (Maybe [Transaction])
getBadTs victimsPath transactionsPath = do
                                            victims <- (parseFile victimsPath :: IO (Maybe [TId]))
                                            transactions <- (parseFile transactionsPath :: IO (Maybe [Transaction]))
                                            return $ Just (filter (\t -> elem (tid t) (fromMaybe [] victims)) (fromMaybe [] transactions))


-- 5
mergeMap :: (Ord k, Num a) => [Map k a] -> Map k a -> Map k a
mergeMap [] result = result
mergeMap (x:xs) result = mergeMap xs (Map.unionWith (+) x result)

assign :: [(String,Integer)] -> Map String Integer -> Map String Integer
assign (x:xs) m = assign xs $ add m x
assign [] m = m

add :: Map String Integer -> (String,Integer) -> Map String Integer
add m (name,ammount) 
            | (Map.member name m) = Map.adjust (+ammount) name m
            | otherwise = Map.insert name ammount m

getFlow :: [Transaction] -> Map String Integer
getFlow ts = assign (concat $ map (\t -> [(from t, (*) (negate 1) (ammount t)),(to t, ammount t)]) ts) Map.empty


-- 6
getCriminal :: Map String Integer -> String
getCriminal m = snd $ maximum $ map (\(x,y) -> (y,x)) $ Map.toList m

-- 7
eventDel :: Map String Integer -> [(String,Integer)]
eventDel m = filter (\x -> (/=) (snd x) 0) (Map.toList m)
         
undoTs :: Map String Integer -> [TId] -> [Transaction]
undoTs m a = let notEvens = eventDel m
                 owe = L.sort $ map (\(x,y) -> (y,x)) (filter (\x -> (>) (snd x) 0) notEvens)
                 damaged = L.sort $ map (\(x,y) -> (y,x)) (filter (\x -> (<) (snd x) 0) notEvens)
             in uHelper damaged owe a
                      
uHelper :: [(Integer,String)] -> [(Integer,String)] -> [TId] -> [Transaction]
uHelper [] _ _ = []
uHelper _ [] _ = []
uHelper _ _ [] = []
uHelper ((px,py):ps) ((dx,dy):ds) (ni:nis) = let ammount = min (negate px) dx in
                                                 (Transaction dy py ammount ni) : (uHelper (if (px + ammount) == 0 then ps else (px,py):ps) (if (dx - ammount) == 0 then ds else (dx,dy):ds) nis)                                

-- 8
writeJSON :: ToJSON a => FilePath -> a -> IO ()
writeJSON new_transactions = BS.writeFile new_transactions . encode

-- 9
runner :: FilePath -> FilePath -> FilePath -> FilePath -> FilePath
             -> FilePath -> IO String
runner dog1 dog2 trans vict fids out = do
  key <- getSecret dog1 dog2
  decryptWithKey key vict
  mts <- getBadTs vict trans
  case mts of
    Nothing -> error "No Transactions"
    Just ts -> do
      mids <- parseFile fids
      case mids of
        Nothing  -> error "No ids"
        Just ids -> do
          let flow = getFlow ts       
          writeJSON out (undoTs flow ids)
          return (getCriminal flow)

main :: IO ()
main = do
  args <- getArgs
  crim <- 
    case args of
      dog1:dog2:trans:vict:ids:out:_ ->
          runner dog1 dog2 trans vict ids out
      _ -> runner "dog-original.jpg"
                        "dog.jpg"
                        "transactions.json"
                        "victims.json"
                        "new-ids.json"
                        "new-transactions.json"
  putStrLn crim