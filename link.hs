module Link ( Link, newL, linksL, connectsL, capacityL, delayL )
   where

import Quality 
import City 


data Link = Lin City City Quality deriving (Eq, Show)

newL :: City -> City -> Quality -> Link -- genera un link entre dos ciudades distintas
newL c1 c2 q | c1 == c2 = error "No se puede vincular una ciudad consigo misma" 
             | otherwise = Lin c1 c2 q

connectsL :: City -> Link -> Bool   -- indica si esta ciudad es parte de este link
connectsL ciudad (Lin ciudad1 ciudad2 _) = ciudad == ciudad1 || ciudad == ciudad2

linksL :: City -> City -> Link -> Bool -- indica si estas dos ciudades distintas estan conectadas mediante este link
linksL ciudad1 ciudad2 (Lin ciudad3 ciudad4 _) = (ciudad1 == ciudad3 && ciudad2 == ciudad4) || (ciudad1 == ciudad4 && ciudad2 == ciudad3)

capacityL :: Link -> Int
capacityL (Lin _ _ calidad) = capacityQ calidad

delayL :: Link -> Float -- la demora que sufre una conexion en este canal
delayL (Lin _ _ calidad) = delayQ calidad