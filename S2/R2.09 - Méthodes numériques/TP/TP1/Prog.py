#prog 1 
import math

def SN(x: float, n: int) :
    resultat: float 
    resultat = 0
    for i in range(n + 1):
        resultat += (x ** i) / math.factorial(i)
    print("Série de Taylor : ", resultat)

#prog 2
def TN(x : float, n : int) :
    resultat: float
    while n == 0 : 
        print("Ressaisir N")
        n = int(input())
    resultat = (1 + x/n)**n
    print("Approximation de l'exponentielle : ", resultat)


if __name__ == "__main__":
    print("Quelle formule voulez-vous utiliser ?")
    print("1. Série de Taylor")
    print("2. Approximation de l'exponentielle")
    choix = int(input("Votre choix : "))

    if choix == 1:
        print("Entrez x")
        x = float(input("Votre choix : "))
        print("Entrez n")
        n = int(input("Votre choix : "))
        SN(x, n)
    elif choix == 2:
        print("Entrez x")
        x = float(input("Votre choix : "))
        print("Entrez n")
        n = int(input("Votre choix : "))
        TN(x, n)
    else:
        print("Erreur de saisie")
    

