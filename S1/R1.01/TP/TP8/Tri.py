def est_trié(liste : list[int]) -> bool :
    """
    Vérifie si un tableau est trié
    Args:
        liste (list[int]): Tableau à vérifier
    Returns:
        bool: True si le tableau est trié, False sinon
    """

    i : int
    tri : bool
    tri = True
    for i in range(len(liste)-1) :
        if liste[i] > liste[i+1] :
            tri = False
    return tri

def recherche_dicho(liste : list[int], x : int) -> int :
    """
    Recherche un élément dans un tableau trié
    Args:
        liste (list[int]): Tableau trié
        x (int): Element à rechercher
    Returns:
        int: Indice de l'élément recherché, -1 si non trouvé
    """
    
    a : int
    b : int
    m : int
    p : int
    p = -1
    a = 0
    b = len(liste) - 1
    m = (a+b)//2
    if est_trié(liste) :
        while a < b :
            m = (a+b)//2
            if x <= liste[m] :
                b = m
            else:
                a = m+1
        if liste[a] == x : 
            p = a 
        else : 
            p = -1
        print("Le numéro est à l'indice : ", p,"\nOu sinon à la position : ", p+1)
        return p
    else :
        print("Le tableau n'est pas triée")
        return p
    
# #############################################################################
# ############################################################################
# #############################################################################

def tri_insertion(liste : list[int]) -> list[int] :
    """
    Trie un tableau par insertion
    Args:
        liste (list[int]): Tableau à trier
    Returns:
        list[int]: Tableau trié
    """
    val :int
    i : int
    j : int
    n : int
    n = len(liste)
    for i in range(1, n) :
        val = liste[i]
        j = i
        while j > 0 and liste[j-1] > val :
            liste[j] = liste[j-1]
            j = j-1
        liste[j] = val
    return liste

# #############################################################################
# ############################################################################
# #############################################################################

def tri_bulles(liste : list[int]) -> list[int] :
    """
    Trie un tableau par tri à bulles
    Args:
        liste (list[int]): Tableau à trier
    Returns:
        list[int]: Tableau trié
    """
    
    p : int
    echange : bool
    tmp : int
    i :int
    p = len(liste)-1
    echange = True
    while echange and p > 0 :
        echange = False
        for i in range(0, p) :
            if liste[i] > liste[i+1] :
                tmp = liste[i]
                liste[i] = liste[i+1]
                liste[i+1] = tmp
                echange = True
        p = p-1
    return liste