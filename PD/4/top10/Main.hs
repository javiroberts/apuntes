module Main where

import System.Environment (getArgs)
import qualified Data.Map as M
import qualified Data.List as L

main :: IO ()
main = do 
         args <- getArgs
         words  <- read args 0
         putStrLn  $ show
                   $ L.take 10
                   $ L.reverse
                   $ L.sort
                   $ map (\(x,y) -> (y,x))
                   $ M.toList
                   $ assign words (M.empty :: M.Map String Int)

read :: [String] -> Int -> IO [String]
read [] _ = return ["at least 1 arg required"]
read list index | (<) index $ L.length list =  do
                      content <- readFile $ list !! index
                      return $ words content 
                | otherwise = return []

assign :: [String] -> M.Map String Int -> M.Map String Int
assign (x:xs) map = assign xs $ add map x
assign [] map = map

add :: M.Map String Int -> String -> M.Map String Int
add map word 
            | (M.member word map) = M.adjust (+1) word map
            | otherwise = M.insert word 1 map