def nbrvoyelles (chaine : str) -> int:
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



if __name__ == "__main__":
    chaine : str
    choix : int 
    cond : bool
    cond = True

    while cond == True: 
        choix = int(input("Veuillez choisir une option : \n1. Compter le nombre de voyelles\n2. Vérifier si la chaine est un palindrome\n3. Quitter\n"))
        if choix == 3:
            print("Au revoir")
            exit()
        chaine = input("Veuillez saisir une chaine de caractères : ")

        if choix == 1:
            print("Le nombre de voyelles dans la chaine est : ", nbrvoyelles(chaine))
            cond = False

        if choix == 2:
            if palindrome(chaine):
                print("La chaine " + "-" + chaine + "-" + " est un palindrome")
                cond = False
            else:
                print("La chaine" + "-" + chaine + "-" + " n'est pas un palindrome")
                cond = False
        else:
            print("Veuillez choisir une option valide")
            cond = True

    