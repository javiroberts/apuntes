-- 1
data Titulo = Ducado | Marquesado | Condado | Vizcondado | Baronia

hombre :: Titulo -> String 
hombre Ducado = "Duque"
hombre Marquesado = "Marques"
hombre Condado = "Conde"
hombre Vizcondado = "Vizconde"
hombre Baronia = "Baron"

dama :: Titulo -> String
dama Ducado = "Duquesa"
dama Marquesado = "Marquesa"
dama Condado = "Condesa"
dama Vizcondado = "Vizcondesa"
dama Baronia = "Baronesa"

-- 2
type Territorio = String
type Nombre = String
data Genero = Hombre | Mujer
data Persona = Rey Genero               
            | Noble Genero Titulo Territorio 
            | Caballero Genero Nombre        
            | Aldeano Genero Nombre          

tratamiento :: Persona -> String
tratamiento (Rey Hombre) = "Su majestad el rey"
tratamiento (Rey Mujer) = "Su majestad la reina"
tratamiento (Noble Hombre titulo territorio) = "El " ++ (hombre titulo) ++ " de " ++ territorio
tratamiento (Noble Mujer titulo territorio) = "La " ++ (dama titulo) ++ " de " ++ territorio
tratamiento (Caballero Hombre nombre) = "Sir " ++ nombre
tratamiento (Caballero Mujer nombre) = "Lady " ++ nombre
tratamiento (Aldeano _ nombre) = nombre

-- 3
division_segura :: Int -> Int -> Maybe Int
division_segura _ 0 = Nothing
division_segura num1 num2 = Just (num1 `div` num2)

cabeza :: [a] -> Maybe a 
cabeza [] = Nothing
cabeza list = Just (head list)

suma_maybe :: Maybe Int -> Maybe Int -> Maybe Int
suma_maybe (Just a) (Just b) = Just (a + b)
suma_maybe Nothing _ = Nothing
suma_maybe _ Nothing = Nothing