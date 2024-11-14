from time import time
from random import randint
from Tri import *
#############################################################################
def creer_tableau(n: int) -> list[int]:
    """
    Créer un tableau de taille n qui se rempli tout seul d'entiers aléatoires

    Args:
        n (int): Taille du tableau

    Returns:
        list[int]: Tableau rempli d'entiers aléatoires
    """
    tableau : list[int] 

    tableau = []
    for i in range(n):
        tableau.append(randint(0, 100))
        i += 1
    
    return tableau

#############################################################################

def afficher_tableau(tableau: list[int]) -> None : 
    """
    Affiche le tableau de manière lisible

    Args:
        tableau (list[int]): Tableau à afficher
    """
    for i in range(len(tableau)) :
        print("Valeur",i, "=", tableau[i], "\n")
    

#############################################################################
#############################################################################
#############################################################################

if __name__ == "__main__":
    choix : int 
    continuer : bool
    tableau : list[int]
    tableau_creer : bool
    tableau_trier : bool

    tableau = []
    tableau_creer = False
    tableau_trier = False
    continuer = True



    while continuer == True :
        print("Bienvenue dans le programme de tri de tableau")
        choix = int(input("1. Créer un nouveau tableau\n2. Afficher le tableau de manière lisible\n3. Trier le tableau (Tri à bulle) + afficher temps\n4. Trier le tableau (Tri insertion) + afficher temps\n5. Rechercher un élément dans un tableau trié\n6. Quitter\n--> "))

        while choix < 1 or choix > 6:
            print("Veuillez choisir un nombre entre 1 et 6")
            choix = int(input("1. Créer un nouveau tableau\n2. Afficher le tableau de manière lisible\n3. Trier le tableau (Tri à bulle) + afficher temps\n4. Trier le tableau (Tri insertion) + afficher temps\n5. Rechercher un élément dans un tableau trié\n6. Quitter\n--> "))


        if choix == 1:
                n = int(input("Veuillez entrer la taille du tableau à créer: "))
                tableau = creer_tableau(n)
                tableau_creer = True
                print("-----------------------------")
                print("\033[0;32mTableau créé \033[0m \n")

        if choix == 2 and tableau_creer == True :
            afficher_tableau(tableau)
            print("\n")

        if choix == 3 and tableau_creer == True:
            debut = time()
            tri_bulles(tableau)
            fin = time()
            tableau_trier = True
            print("-----------------------------")
            print("\033[0;32mTableau trié avec tri bulle avec succès en",fin - debut,"secondes \033[0m")
            print("\n")

        if choix == 4 and tableau_creer == True:
            debut = time()
            tri_insertion(tableau)
            fin = time()
            tableau_trier = True
            print("-----------------------------")
            print("\033[0;32mTableau trié avec tri insertion avec succès en",fin - debut,"secondes \033[0m")
            print("\n")

        if choix == 5 and tableau_creer == True and tableau_trier == True :
            recherche_dicho(tableau, int(input("Veuillez entrer le nombre à rechercher: ")))
            print("-----------------------------")
            print("\033[0;32mRecherche d'un élément dans un tableau trié \033[0m")
            print("\n")



        if choix != 1 and tableau_creer == False : 
            print("-----------------------------")
            print("\033[0;31mVeuillez créer un tableau avant de continuer  \033[0m")

        if choix == 6:
            print("Au revoir")
            continuer = False