#Affiche une pyramide de hauteur n avec des "*"
if __name__ == '__main__':
    n : float
    i : int
    j : int

    n = float(input("Entrez un entier: "))

    #Vérification de la saisie
    while n < 0 or n != int(n):
        n = float(input("Entrez un entier positif: "))

    if n == 0:
        print("La pyramide est vide")
    #Affichage de la pyramide
    for i in range(1,int(n+1)):
        for j in range(1,int(n-i+1)):
            print(" ",end="")
        for j in range(1,2*i):
            print("*",end="")
        print()


