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