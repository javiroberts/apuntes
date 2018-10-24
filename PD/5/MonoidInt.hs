import Data.Monoid ( (<>) )

-- esto funcina con GHC hasta 8.2, para versiones
-- ulteriores hay que definir instancias para
-- la clase Semigroup primero.

newtype Suma = Suma Int deriving Show
newtype Prod = Prod Int deriving Show

{- definir instancias para Monoid
   luego probar en GHCi:

   *Main> (Suma 9) <> (Suma 100) <> (Suma 34)
   Suma 143
   *Main> (Prod 9) <> (Prod 100) <> (Prod 34)
   Prod 30600
-}

instance Monoid Suma where
  mempty = Suma 0
  mappend (Suma a) (Suma b) = Suma (a+b)

instance Monoid Prod where
  mempty = Prod 1
  mappend (Prod a) (Prod b) = Prod (a*b)
