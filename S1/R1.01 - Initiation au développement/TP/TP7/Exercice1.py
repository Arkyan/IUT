def saisieMat(nlig : int, ncol : int) -> list[list[float]] :
    mat : list[list[float]]
    i : int
    j: int
    val : float
    mat = list([])
    for i in range(0, nlig) :
        i = i 
        ligne : list[float]
        ligne = list()
        for j in range(0, ncol) :
            val = j+1
            ligne.append(val)
        mat.append(ligne)
    return mat

def exPassage(lst : list[str], val : int) :
    print("Modification dans la procédure")
    lst[0] = "zéro"
    val = val*2
    print(lst)
    print(val)



##################################################
######## Saisie et affichage + Matrice ###########
##################################################
if __name__ =="__main__" :
    liste : list[int]
    listemot : list[str]
    val : int
    i : int
    liste = []
    for i in range(0,10) :
        liste.append(i+1)
        print(liste)
    print(len(liste))
    print()
    print("----------------------------------------------------------------------------")
    print("Initialisation Matrice")
    print("----------------------------------------------------------------------------")
    print()
    print(saisieMat(5,5))
    listemot = ["quatre", "un", "deux", "trois"]
    val = 10
    print()
    print("----------------------------------------------------------------------------")
    print("Passage en paramètre")
    print("----------------------------------------------------------------------------")
    print()
    print(listemot)
    print(val)
    exPassage(listemot, val)
    print(listemot)
    print(val)