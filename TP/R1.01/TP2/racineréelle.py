import math
if __name__ == "__main__" : 
    x : float
    a : float
    b : float
    c : float
    x1 : float
    x2 : float

    a = float(input("Saisir la valeur de a :"))
    b = float(input("Saisir la valeur de b :"))
    c = float(input("Saisir la valeur de c :"))

    if a == 0:
        if b == 0:
            if c == 0:
                print("Tout réel est solution")
            else:
                print("Aucune solution")
        else:
            x = -c / b
            print("La solution est :", x)
    else:
        delta = b * b - 4 * a * c
        if delta > 0 :
            x1 = (-b - math.sqrt(delta)) / (2 * a)
            x2 = (-b + math.sqrt(delta)) / (2 * a)
            print("Les solutions sont :", x1, " et ", x2)
            if delta == 0:
                x = -b / (2 * a)
                print("La solution est :", x)
            else:
                print("Pas de solution dans R")

#Liste des tests :
#Test 1 : a = 1, b = 1, c = 1 => Pas de solution dans R
#Test 2 : a = 1, b = 2, c = 1 => La solution est : -1.0
#Test 3 : a = 1, b = 3, c = 2 => Les solutions sont : -2.0  et  -1.0
#Test 4 : a = 0, b = 0, c = 0 => Tout réel est solution
#Test 5 : a = 0, b = 0, c = 1 => Aucune solution
#Test 6 : a = 0, b = 1, c = 1 => La solution est : -1.0
#Test 7 : a = 1, b = 0, c = 1 => Pas de solution dans R
#Test 8 : a = 1, b = 0, c = 0 => La solution est : 0.0
#Test 9 : a = 1, b = 1, c = 0 => Les solutions sont : -1.0  et  0.0
#Test 10 : a = 1, b = 1, c = 1 => Pas de solution dans R
#Test 11 : a = 1, b = 2, c = 1 => La solution est : -1.0
#Test 12 : a = 1, b = 3, c = 2 => Les solutions sont : -2.0  et  -1.0
#Avec nombre négatif
#Test 13 : a = -1, b = -1, c = -1 => Pas de solution dans R
#Test 14 : a = -1, b = -2, c = -1 => Les solutions sont : -1.0  et  0.0
#Test 15 : a = -1, b = -3, c = -2 => La solution est : -1.0
#Test 16 : a = 0, b = 0, c = -1 => Aucune solution
#Test 17 : a = 0, b = -1, c = -1 => La solution est : 1.0
#Test 18 : a = -1, b = 0, c = -1 => Pas de solution dans R