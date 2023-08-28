import Tunel 
import Link 
import Point 
import Quality 
import City 
import Region

point1 = newP 0 0 
point2 = newP 4 9
point3 = newP 10 4
point4 = newP 4 4

city1 = newC "GaiaLandia" point1
city2 = newC "NachoLandia" point2
city3 = newC "UdeSA City" point3
city4 = newC "Victoria" point4

metal = newQ "metal" 2 0.2

gaiaToVictoria = newL city1 city2 metal
victoriaToNacho = newL city2 city3 metal 
tunel = newT [gaiaToVictoria, victoriaToNacho]

argentina = linkR ( foundR ( foundR (foundR newR city1) city2) city3) city1 city2 metal


test = [difP point1 point2 == 10.0,
        delayT tunel == 1.0 ,
        nameC city1 == "GaiaLandia", 
        nameC city2 == "NachoLandia", 
        distanceC city1 city2 == 12.0, 
        capacityL gaiaToVictoria == 2,
        capacityQ metal == 2, 
        delayQ metal == 0.2,
        delayL gaiaToVictoria == 0.2, 
        connectsL city2 gaiaToVictoria, 
        connectsT city1 city2 tunel, 
        linksL city4 city2 victoriaToNacho, 
        linksL city1 city4 gaiaToVictoria, 
        usesT victoriaToNacho tunel, 
        delayT tunel == 1.0,
        connectedR argentina city1 city2,
        not (connectedR argentina city1 city3),
        linkedR argentina city1 city2,
        True
        ]