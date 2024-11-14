def saisie() -> list[str] :
    """
    Permet de saisir des noms et de les stocker dans une liste
    Args:
        None
    Returns:
        list[str] : liste de noms
    """
    listnom : list[str] 
    nom : str
    encore : str
    encore = "o"

    listnom = []
    while encore == "o" :
        nom = input("Veuillez saisir un nom : ")
        while nom == "":
            nom = input("Veuillez saisir un nom valide : ")
            encore = "o"
        
        listnom.append(nom)
        encore = input("Voulez-vous saisir un autre nom ? (o = oui/n = non) : \n Saisir o ou n : ")

    return listnom
########################################################################################
def voyelle (chaine : str) -> int:
    """
    Fonction qui compte le nombre de voyelles dans une chaine de caractères
    Args:
        chaine : str : chaine de caractères
    Returns:
        int : le nombre de voyelles dans la chaine
    """
    voyelles : list[str]

    voyelles = ['a', 'e', 'i', 'o', 'u', 'y', 'A', 'E', 'I', 'O', 'U', 'Y']
    nb_voyelles = 0
    for lettre in chaine:
        if lettre in voyelles:
            nb_voyelles += 1
    return nb_voyelles
########################################################################################
def palindrome (chaine : str) -> bool:
    """
    Fonction qui vérifie si une chaine de caractères est un palindrome
    Args:
        chaine : str : chaine de caractères
    Returns:
        bool : True si la chaine est un palindrome, False sinon
    """

    chaine = chaine.replace(" ", "")
    return chaine == chaine[::-1]
########################################################################################
def afficherPalindromes(listnom : list[str]) -> None:
    """
    Fonction qui affiche les palindromes dans une liste de noms
    Args:
        listnom : list[str] : liste de noms
    Returns:
        None
    """
    for nom in listnom:
        if palindrome(nom):
            print("Le nom " + "-" + nom + "-" + " est un palindrome")
########################################################################################
if __name__ == "__main__":  
    listnom : list[str]
    cond : bool
    choix : int
    choix2 : int
    cond = True
    print("\033c", end="")

    while cond == True: 
        choix = int(input("Veuillez choisir une option : \n1. Saisir un tableau de nom\n2. Afficher le nombre de voyelles par nom\n3. Afficher uniquement les noms étant des palindromes \n4. Quitter\n--> "))

        if choix == 1:
            listnom = saisie()
            print("\033c", end="")
            choix2 = int(input("Veuillez choisir une option : \n1. Afficher le nombre de voyelles par nom\n2. Afficher uniquement les noms étant des palindromes \n3. Quitter\n"))

            if choix2 == 1 :
                for nom in listnom:
                    print("Le nombre de voyelles dans le nom " + "-" + nom + "-" + " est : ", voyelle(nom))
                cond = False

            if choix2 == 2:
                afficherPalindromes(listnom)
                cond = False

            if choix2 == 3:
                print("Au revoir")
                cond = False
        
        if choix == 2 or choix == 3:
            print("\033c", end="")
            print("Veuillez d'abord saisir un tableau de noms")
            cond = True

        if choix == 4:
            print("\033c", end="")
            print("Au revoir")
            cond = False

        if choix != 1 and choix != 2 and choix != 3 and choix != 4:
            print("\033c", end="")
            print("Veuillez choisir une option valide")
            cond = True
            



    