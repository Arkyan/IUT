class Livre:
    def __init__(self, titre: str, auteur: str, annee: int, nbpages: int):
        self.titre = titre
        self.auteur = auteur
        self.annee = annee
        self.nbPages = nbpages

    def __str__(self):
        return f"Titre: {self.titre}, Auteur: {self.auteur}, Année de publication: {self.annee}, Nombre de pages: {self.nbPages}"

############################################
############################################
############################################

def afficher_menu() -> int: 
    """
    Fonction qui affiche le menu de la bibliothèque et qui retourne le choix de l'utilisateur
    Args:
        None : None
    Returns:
        int: le choix de l'utilisateur
    """
    choix : int

    print("1. Afficher l'ensembles des livres de la bibliothèque")
    print("2. Ajouter un nouveau livre")
    print("3. Rechercher un livre par son titre")
    print("4. Quitter")

    choix = int(input("Entrez votre choix: "))

    return choix

############################################
############################################
############################################

def afficher_bibliothèque(bibliothèque: list[Livre]) -> None:
    """
    Fonction qui affiche l'ensemble des livres de la bibliothèque
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """
    for livre in bibliothèque:
        print(livre)

############################################
############################################
############################################

def ajouter_livre(bibliothèque: list[Livre]) -> None:
    """
    Fonction qui ajoute un livre à la bibliothèque
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """
    titre : str 
    titre = input("Entrez le titre du livre: ")

    auteur : str 
    auteur = input("Entrez le nom de l'auteur: ")

    annee : int 
    annee = int(input("Entrez l'année de publication: "))

    nbpages : int 
    nbpages = int(input("Entrez le nombre de pages: "))

    livre = Livre(titre, auteur, annee, nbpages)
    bibliothèque.append(livre)

############################################
############################################
############################################

def rechercher_livre(bibliothèque: list[Livre]) -> None:
    """
    Fonction qui recherche un livre par son titre
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """
    titre : str 
    titre = input("Entrez le titre du livre: ")

    for livre in bibliothèque :
        if livre.titre == titre :
            print(livre)
        else:
            print("Le livre n'existe pas dans la bibliothèque")

############################################
############################################
############################################

if __name__ == "__main__":
    bibliothèque : list[Livre] = []
    choix : int

    while True:
        choix = afficher_menu()

        if choix == 1:
            afficher_bibliothèque(bibliothèque)
        if choix == 2:
            ajouter_livre(bibliothèque)
        if choix == 3:
            rechercher_livre(bibliothèque)
        if choix == 4:
            exit()
        else :
            print("Choix invalide")