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

############################################

def longueur(li: ListeChainee) -> int:
    """
    Fonction qui renvoie la longueur de la liste

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

############################################
    
def afficheLC(li: ListeChainee):
    """
    Fonction qui affiche les éléments de la liste

    Dans cette version, chaque élément est affiché sur une ligne

    Args:
        li (ListeChainee): la liste que l'on veut afficher
    """
    courant = li.tete
    while(courant):
        print(courant.data)
        courant = courant.suivant

############################################

def ajoutQueue(li: ListeChainee, val: int):
    """
    Fonction qui ajoute un élément en queue de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    # on crée un nouveau maillon
    nouveauMaillon = Maillon()
    nouveauMaillon.data = val
    nouveauMaillon.suivant = None
    # si la liste est vide
    if li.tete == None:
        li.tete = nouveauMaillon
    else:
        # on parcourt la liste jusqu'à la fin
        courant = li.tete
        while(courant.suivant):
            courant = courant.suivant
        # on ajoute le nouveau maillon
        courant.suivant = nouveauMaillon

############################################

def ajoutTete(li: ListeChainee, val: int):
    """
    Fonction qui ajoute un élément en tête de liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        val (int): la valeur de l'élément à ajouter
    """
    # on crée un nouveau maillon
    nouveauMaillon = Maillon()
    nouveauMaillon.data = val
    # on fait pointer le nouveau maillon sur l'ancienne tête
    nouveauMaillon.suivant = li.tete
    # on met à jour la tête de liste
    li.tete = nouveauMaillon

############################################

def ajoutEnPos(li: ListeChainee, indice : int, val: int):
    """
    Ajoute un élément à une position donnée dans la liste

    Args:
        li (ListeChainee): la liste à laquelle on veut ajouter un élément
        indice (int): la position où insérer l'élément (0 pour la tête)
        val (int): la valeur de l'élément à ajouter
    """
    if indice == 0:  # Ajouter en tête
        ajoutTete(li, val)
        return
    
    courant = li.tete
    pos = 0
    while courant and pos < indice - 1:
        courant = courant.suivant
        pos += 1
    
    if courant is None:  # Si l'indice dépasse la longueur
        print("Indice invalide. L'ajout n'a pas été effectué.")
        return

############################################

def suppTete(li : ListeChainee):
    """
    Supprime l'élément en tête de la liste

    Args:
        li (ListeChainee): la liste dont on veut supprimer la tête
    """
    if li.tete is None:  # Liste vide
        print("Impossible de supprimer la tête d'une liste vide.")
        return
    li.tete = li.tete.suivant

############################################

def suppQueue(li : ListeChainee):
    """
    Supprime l'élément en queue de la liste

    Args:
        li (ListeChainee): la liste dont on veut supprimer la queue
    """
    if li.tete is None:  # Liste vide
        print("Impossible de supprimer la queue d'une liste vide.")
        return
    
    if li.tete.suivant is None:  # Un seul élément
        li.tete = None
        return
    
    courant = li.tete
    while courant.suivant and courant.suivant.suivant:
        courant = courant.suivant
    
    if courant.suivant:
        courant.suivant = None

############################################

def suppEnPos(li: ListeChainee, indice : int):
    """
    Supprime un élément à une position donnée dans la liste

    Args:
        li (ListeChainee): la liste dont on veut supprimer un élément
        indice (int): la position de l'élément à supprimer
    """
    if indice == 0:  # Supprimer la tête
        suppTete(li)
        return
    
    courant = li.tete
    pos = 0
    while courant and pos < indice - 1:
        courant = courant.suivant
        pos += 1
    
    if courant is None or courant.suivant is None:  # Indice invalide
        print("Indice invalide. La suppression n'a pas été effectuée.")
        return

############################################

def recherche(li: ListeChainee, val : int) -> int :
    """
    Recherche la première occurrence d'une valeur dans la liste

    Args:
        li (ListeChainee): la liste dans laquelle chercher
        val (int): la valeur à rechercher

    Returns:
        int: l'indice de la première occurrence, ou -1 si non trouvée
    """
    courant = li.tete
    indice = 0
    while courant:
        if courant.data == val:
            return indice
        courant = courant.suivant
        indice += 1
    return -1

############################################

if __name__=="__main__" :
    maLC = ListeChainee()
    maLC.tete = None
    # ecrire tous les tests / jeux d'essai
    # permettant de mettre en évidence le fonctionnement de la liste
    # ainsi que les cas particuliers (impossible de supprimer un élément 
    # d'une liste vide par exemple)
    # Tests
    ajoutTete(maLC, 10)
    ajoutQueue(maLC, 20)
    ajoutQueue(maLC, 30)
    ajoutEnPos(maLC, 1, 15)
    afficheLC(maLC)

    print("Longueur:", longueur(maLC))
    print("Recherche 15:", recherche(maLC, 15))
    print("Recherche 100:", recherche(maLC, 100))
    print("Recherche 10:", recherche(maLC, 10))

    suppEnPos(maLC, 1)
    afficheLC(maLC)

    suppTete(maLC)
    afficheLC(maLC)

    suppQueue(maLC)
    afficheLC(maLC)