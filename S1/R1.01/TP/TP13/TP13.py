# =================================================================
#
# Code support du TP chaine d'entiers
# 
# Non redistibuable en dehors du Département Informatique de l'IUT
#
# =================================================================

from typing import Optional

# structure de maillon
class Maillon:
    data: int
    suivant: Optional["Maillon"]

# structure de liste
class ListeChainee:
    tete: Optional[Maillon]

class MaillonDouble:
    data: int
    suivant: Optional["MaillonDouble"]
    precedent: Optional["MaillonDouble"]
    
class ListeChainee1:
    tete: Optional[MaillonDouble]
        
def longueur(li: ListeChainee) -> int:
    """Fonction qui renvoie la longueur de la liste

    Args:
        li (ListeChainee): la liste dont on veut connaître la longueur

    Returns:
        int: la longueur de la liste
    """
    courant = li.tete
    long = 0
    while(courant):
        long += 1
        courant = courant.suivant
    return long
   

def afficheLC(li: ListeChainee):
    """Fonction qui affiche les éléments de la liste

    Dans cette version, chaque élément est affiché sur une ligne

    Args:
        li (ListeChainee): la liste que l'on veut afficher
    """
    courant = li.tete
    while(courant):
        print(courant.data)
        courant = courant.suivant


def ajoutQueue(li: ListeChainee, val: int):
    """Fonction qui ajoute un élément en queue de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    if li.tete is None:
        li.tete = Maillon()
        li.tete.data = val
        li.tete.suivant = None
    else:
        courant = li.tete
        while(courant.suivant):
            courant = courant.suivant
        courant.suivant = Maillon()
        courant.suivant.data = val
        courant.suivant.suivant = None


def ajoutTete(li: ListeChainee, val: int):
    """Fonction qui ajoute un élément en tête de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    nouveauMaillon = Maillon()
    nouveauMaillon.data = val
    nouveauMaillon.suivant = li.tete
    li.tete = nouveauMaillon


def ajoutEnPosition(li: ListeChainee, indice : int, val: int):
    """Fonction qui ajoute un élément à l'indice donné dans la liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        indice (int): l'indice où l'on veut ajouter l'élément
        val (int): la valeur de l'élément à ajouter
    """
    if indice == 0:
        ajoutTete(li, val)
    else:
        courant = li.tete
        for i in range(1, indice):
            i = i
            if courant is None:
                print("Indice hors limites")
                return
            courant = courant.suivant
        if courant is None:
            print("Indice hors limites")
        else:
            nouveauMaillon = Maillon()
            nouveauMaillon.data = val
            nouveauMaillon.suivant = courant.suivant
            courant.suivant = nouveauMaillon

def suppTete(li : ListeChainee):
    """Fonction qui supprime l'élément en tête de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
    """
    if li.tete is None:
        print("Liste vide")
    else:
        li.tete = li.tete.suivant


def suppQueue(li : ListeChainee):
    """Fonction qui supprime l'élément en queue de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
    """
    if li.tete is None:
        print("Liste vide")
    else:
        if li.tete.suivant is None:
            li.tete = None
        else:
            courant = li.tete
            while courant.suivant and courant.suivant.suivant:
                courant = courant.suivant
    
            if courant.suivant:
                courant.suivant = None

def suppEnPos(li: ListeChainee, indice : int):
    """Fonction qui supprime l'élément à l'indice donné dans la liste

    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
        indice (int): l'indice de l'élément à supprimer
    """
    if li.tete is None:
        print("Liste vide")
    elif indice == 0:
        suppTete(li)
    else:
        courant = li.tete
        for i in range(1, indice):
            i = i
            if courant is None:
                print("Indice hors limites")
                return
            courant = courant.suivant
        if courant is None or courant.suivant is None:
            print("Indice hors limites")
        else:
            courant.suivant = courant.suivant.suivant


def recherche(li: ListeChainee, val : int) -> int :
    """Fonction qui recherche un élément dans la liste

    Args:
        li (ListeChainee): la liste dans laquelle on veut rechercher un élément
        val (int): la valeur de l'élément à rechercher

    Returns:
        int: l'indice de l'élément recherché s'il est trouvé, -1 sinon
    """
    courant = li.tete
    indice = 0
    while(courant):
        if courant.data == val:
            return indice
        courant = courant.suivant
        indice += 1
    return -1

def ajoutQueueDoubleMaillon(li: ListeChainee1, val: int):
    """Fonction qui ajoute un élément en queue de liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    if li.tete is None:
        li.tete = MaillonDouble()
        li.tete.data = val
        li.tete.suivant = None
        li.tete.precedent = None
    else:
        courant = li.tete
        while(courant.suivant):
            courant = courant.suivant
        courant.suivant = MaillonDouble()
        courant.suivant.data = val
        courant.suivant.suivant = None
        courant.suivant.precedent = courant


def ajoutTeteDoubleMaillon(li: ListeChainee1, val: int):
    """Fonction qui ajoute un élément en tête de liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    nouveauMaillon = MaillonDouble()
    nouveauMaillon.data = val
    nouveauMaillon.suivant = li.tete
    nouveauMaillon.precedent = None
    if li.tete:
        li.tete.precedent = nouveauMaillon
    li.tete = nouveauMaillon


def ajoutEnPositionDoubleMaillon(li: ListeChainee1, indice : int, val: int):
    """Fonction qui ajoute un élément à l'indice donné dans la liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        indice (int): l'indice où l'on veut ajouter l'élément
        val (int): la valeur de l'élément à ajouter
    """
    if indice == 0:
        ajoutTeteDoubleMaillon(li, val)
    else:
        courant = li.tete
        for i in range(1, indice):
            i = i
            if courant is None:
                print("Indice hors limites")
                return
            courant = courant.suivant
        if courant is None:
            print("Indice hors limites")
        else:
            nouveauMaillon = MaillonDouble()
            nouveauMaillon.data = val
            nouveauMaillon.suivant = courant.suivant
            nouveauMaillon.precedent = courant
            if courant.suivant:
                courant.suivant.precedent = nouveauMaillon
            courant.suivant = nouveauMaillon

def suppTeteDoubleMaillon(li : ListeChainee1):
    """Fonction qui supprime l'élément en tête de liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
    """
    if li.tete is None:
        print("Liste vide")
    else:
        li.tete = li.tete.suivant
        if li.tete:
            li.tete.precedent = None

def suppQueueDoubleMaillon(li : ListeChainee1):
    """Fonction qui supprime l'élément en queue de liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
    """
    if li.tete is None:
        print("Liste vide")
    else:
        if li.tete.suivant is None:
            li.tete = None
        else:
            courant = li.tete
            while courant.suivant and courant.suivant.suivant:
                courant = courant.suivant
    
            if courant.suivant:
                courant.suivant = None

def suppEnPosDoubleMaillon(li: ListeChainee1, indice : int):
    """Fonction qui supprime l'élément à l'indice donné dans la liste doublement chainée
    Args:
        li (ListeChainee): la liste à laquelle on veut supprimer un élément
        indice (int): l'indice de l'élément à supprimer
    """
    if li.tete is None:
        print("Liste vide")
    elif indice == 0:
        suppTeteDoubleMaillon(li)
    else:
        courant = li.tete
        for i in range(1, indice):
            i = i
            if courant is None:
                print("Indice hors limites")
                return
            courant = courant.suivant
        if courant is None or courant.suivant is None:
            print("Indice hors limites")
        else:
            courant.suivant = courant.suivant.suivant
            if courant.suivant:
                courant.suivant.precedent = courant

def longueurDoubleMaillon(li: ListeChainee1) -> int:
    """Fonction qui renvoie la longueur de la liste doublement chainée
    Args:
        li (ListeChainee): la liste dont on veut connaître la longueur
    Returns:
        int: la longueur de la liste
    """
    courant = li.tete
    long = 0
    while(courant):
        long += 1
        courant = courant.suivant
    return long

def afficheLCDoubleMaillon(li: ListeChainee1):
    """Fonction qui affiche les éléments de la liste doublement chainée
    Args:
        li (ListeChainee): la liste que l'on veut afficher
    """
    courant = li.tete
    while(courant):
        print(courant.data)
        courant = courant.suivant

if __name__=="__main__" :
    maLC = ListeChainee()
    maLC.tete = None
    maLC1 = ListeChainee1()
    maLC1.tete = None
    # ecrire tous les tests / jeux d'essai
    # permettant de mettre en évidence le fonctionnement de la liste
    # ainsi que les cas particuliers (impossible de supprimer un élément 
    # d'une liste vide par exemple)
    ajoutQueue(maLC, 1)
    ajoutQueue(maLC, 2)
    ajoutQueue(maLC, 3)
    ajoutQueue(maLC, 4)
    ajoutQueue(maLC, 5)
    ajoutQueue(maLC, 6)
    ajoutQueue(maLC, 7)
    ajoutQueue(maLC, 8)
    print("Affichage de la liste : ", afficheLC(maLC))
    print("Longueur de la liste : ", longueur(maLC))
    ajoutTete(maLC, 0)
    ajoutTete(maLC, 15)
    ajoutEnPosition(maLC, 5, 10)
    ajoutEnPosition(maLC, 0, 20)
    ajoutEnPosition(maLC, 12, 30)
    print("Affichage de la liste : ", afficheLC(maLC))
    print("Longueur de la liste : ", longueur(maLC))
    suppTete(maLC)
    suppQueue(maLC)
    print("Affichage de la liste : ", afficheLC(maLC))
    print("Longueur de la liste : ", longueur(maLC))
    suppEnPos(maLC, 5)
    suppEnPos(maLC, 0)
    suppTete(maLC)
    suppQueue(maLC)
    print("Affichage de la liste : ", afficheLC(maLC))
    print("Longueur de la liste : ", longueur(maLC))
    ajoutQueueDoubleMaillon(maLC1, 1)
    ajoutQueueDoubleMaillon(maLC1, 2)
    ajoutQueueDoubleMaillon(maLC1, 3)
    ajoutQueueDoubleMaillon(maLC1, 4)
    ajoutQueueDoubleMaillon(maLC1, 5)
    ajoutQueueDoubleMaillon(maLC1, 6)
    ajoutQueueDoubleMaillon(maLC1, 7)
    ajoutQueueDoubleMaillon(maLC1, 8)
    print("Affichage de la liste : ", afficheLCDoubleMaillon(maLC1))
    print("Longueur de la liste : ", longueurDoubleMaillon(maLC1))
    ajoutTeteDoubleMaillon(maLC1, 0)
    ajoutTeteDoubleMaillon(maLC1, 15)
    ajoutEnPositionDoubleMaillon(maLC1, 5, 10)
    ajoutEnPositionDoubleMaillon(maLC1, 0, 20)
    ajoutEnPositionDoubleMaillon(maLC1, 12, 30)
    print("Affichage de la liste : ", afficheLCDoubleMaillon(maLC1))
    print("Longueur de la liste : ", longueurDoubleMaillon(maLC1))
    suppTeteDoubleMaillon(maLC1)
    suppQueueDoubleMaillon(maLC1)
    print("Affichage de la liste : ", afficheLCDoubleMaillon(maLC1))
    print("Longueur de la liste : ", longueurDoubleMaillon(maLC1))
    suppEnPosDoubleMaillon(maLC1, 5)
    suppEnPosDoubleMaillon(maLC1, 0)
    suppTeteDoubleMaillon(maLC1)
    suppQueueDoubleMaillon(maLC1)
    print("Affichage de la liste : ", afficheLCDoubleMaillon(maLC1))
    print("Longueur de la liste : ", longueurDoubleMaillon(maLC1))