{-# OPTIONS_GHC -Wall #-}
module Poly where
import Data.List (intercalate)

data Poly a = P [a]

-- 1
instance (Num a, Eq a) => Eq (Poly a) where
    (P xs) == (P ys) = sanitize (reverse xs) == sanitize (reverse ys)

sanitize :: (Num a,Eq a) => [a] -> [a]
sanitize (0 : xs) = sanitize xs
sanitize xs = xs
 
-- 2
instance (Num a, Eq a, Show a) => Show (Poly a) where
    show (P xs) =  intercalate " + " $ reverse $ zipWith string [0..]  xs

string :: (Num a, Show a, Eq a) => Integer -> a -> String
string 0 c = show c
string e c = show c ++ "x^" ++ show e

-- 3
plus :: Num a => Poly a -> Poly a -> Poly a
plus (P a) (P b) = let count = max (length a) (length b)
                       a_diff = (count - (length a))
                       b_diff = (count - (length b))
                   in P $ zipWith (+) (fillNullIndexes 0 a_diff a) (fillNullIndexes 0 b_diff b)
                   
fillNullIndexes :: a -> Int -> [a] -> [a]
fillNullIndexes filler count items
                    | count > 0 = fillNullIndexes filler (count - 1) (reverse (filler: (reverse items)))
                    | otherwise = items
                       

-- 4
indexedList :: [a] -> [(Int,a)]
indexedList = zip [0..]

multiplyElements :: Num a => a -> [a] -> [a]
multiplyElements val elements = map (*val) elements

addLeadingZeros :: a -> Int -> [a] -> [a]
addLeadingZeros filler count a = (++) (replicate count filler) a

times :: Num a => Poly a -> Poly a -> Poly a
times (P []) (P _) = P []
times (P _) (P []) = P []
times (P a) (P b) = sum (map (\(xa,xb) -> P (multiplyElements xb (addLeadingZeros 0 xa a))) (indexedList b))
 

-- 5
instance Num a => Num (Poly a) where
    (+) = plus
    (*) = times
    negate (P a) = P $ map negate a
    fromInteger i =  P [fromInteger i]
    abs    = undefined
    signum = undefined    
    
-- 6
x :: Num a => Poly a
x = P[0,1]

-- 7
applyP :: Num a => Poly a -> a -> a
applyP (P a) val = sum (map (\(xa,xb) -> val^xa * xb) (indexedList a))