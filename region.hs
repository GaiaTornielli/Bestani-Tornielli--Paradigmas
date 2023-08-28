module Region ( Region, newR, foundR, linkR, tunelR, connectedR, linkedR, delayR,
availableCapacityForR )
   where

import City
import Link
import Tunel
import Quality

data Region = Reg [City] [Link] [Tunel]
newR :: Region
newR = Reg [] [] []

foundR :: Region -> City -> Region -- agrega una nueva ciudad a la región
foundR (Reg cities links tunnels) city = Reg (city:cities) links tunnels

linkR :: Region -> City -> City -> Quality -> Region -- enlaza dos ciudades de la región con un enlace de la calidad indicada
linkR (Reg cities links tunnels) city1 city2 quality = Reg cities (newL city1 city2 quality:links) tunnels

tunelR :: Region -> [ City ] -> Region -- genera una comunicación entre dos ciudades distintas de la región
tunelR (Reg cities links tunnels) [city1, city2]
   | city1 /= city2 && elem city1 cities && elem city2 cities = Reg cities links (newTunnel : tunnels)
   | otherwise = Reg cities links tunnels
   where
      newTunnel = Tunel city1 city2 (filter (linksL city1 city2) links)

connectedR :: Region -> City -> City -> Bool -- indica si estas dos ciudades estan conectadas por un tunel

connectedR (Reg cities links tunnels) city1 city2 = any (== [city1, city2]) (map citiesT tunnels) 

linkedR :: Region -> City -> City -> Bool -- indica si estas dos ciudades estan enlazadas
linkedR (Reg cities links tunnels) city1 city2 = any (== [city1, city2]) (map citiesL links)

delayR :: Region -> City -> City -> Float -- dadas dos ciudades conectadas, indica la demora
delayR (Reg cities links tunnels) city1 city2 = delayT (head (filter (== [city1, city2]) (map citiesT tunnels))) 

availableCapacityForR :: Region -> City -> City -> Int -- indica la capacidad disponible entre dos ciudades
availableCapacityForR (Reg cities links tunnels) city1 city2 = minimum (map capacityL (filter (== [city1, city2]) (map citiesL links))) 