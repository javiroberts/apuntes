{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

import qualified Data.Set as S

class Eq e => Collection c e where
    insert :: c -> e -> c
    member :: c -> e -> Bool

instance Eq a => Collection [a] a where
    insert xs x = x:xs
    member = flip elem

instance Eq a => Collection (S.Set a) a where
    insert s a = S.insert a s
    member s a = S.member a s