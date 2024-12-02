class Auteur : 
        """
        Classe qui représente un auteur
        Args:
            nom (str): le nom de l'auteur
            prenom (str): le prénom de l'auteur
            dateNaissance (str): la date de naissance de l'auteur
            nationalite (str): la nationalité de l'auteur
            DateDeces (str): la date de décès de l'auteur
        """

        def __init__(self, nom: str, prenom: str,nationalite: str,dateNaissance: str, dateDeces : str) :
            self.nom = nom
            self.prenom = prenom
            self.nationalite = nationalite
            self.dateNaissance = dateNaissance
            self.DateDeces = None # Par défaut, l'auteur est en vie

        def __str__(self):
            return f"Nom : {self.nom} | Prénom : {self.prenom} | Nationalité : {self.nationalite} | Date de naissance : {self.dateNaissance} | Date de décès : {self.DateDeces}"

class Livre:
    """
    Classe qui représente un livre
    Args:
        titre (str): le titre du livre
        auteur (str): le nom de l'auteur
        annee (int): l'année de publication
        nbPages (int): le nombre de pages
    """

    def __init__(self, titre: str, auteur : Auteur, annee: int, nbpages: int):
        self.titre = titre
        self.auteur = auteur
        self.annee = annee
        self.nbPages = nbpages

    def __str__(self):
        return f"Titre : {self.titre} | Auteur : {self.auteur} | Année : {self.annee} | Nombre de pages : {self.nbPages}"

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
    print("3. Ajouter un nouvel auteur")
    print("4. Rechercher un livre par son titre")
    print("5. Quitter")

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
    if len(bibliothèque) == 0:
        print("La bibliothèque est vide")

############################################
############################################
############################################

def afficher_liste_auteurs(ListeAuteur: list[Auteur]) -> None:
    """
    Fonction qui affiche l'ensemble des auteurs de la bibliothèque avec leurs indices
    Args:
        ListeAuteur (list[Auteur]): la liste des auteurs de la bibliothèque
    Returns:
        None
    """
    if not ListeAuteur:
        print("La liste des auteurs est vide")
        return

    print("Liste des auteurs :")
    for i, auteur in enumerate(ListeAuteur):
        print(f"{i} --> {auteur}")
    
############################################
############################################
############################################

def ajouter_auteur(listeAuteurs : list[Auteur]) -> None:
    """
    Fonction qui ajoute un auteur à la bibliothèque
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """

    nom : str 
    nom = input("Entrez le nom de l'auteur: ")

    prenom : str 
    prenom = input("Entrez le prénom de l'auteur: ")

    nationalite : str 
    nationalite = input("Entrez la nationalité de l'auteur: ")

    dateNaissance : str 
    dateNaissance = input("Entrez la date de naissance de l'auteur: ")

    choix = input("Est-il décédé ?").capitalize()
    if choix == "Oui" : 
        datedeces : str
        datedeces = input("Quelle est sa date de décès :")
    else :
        print("Alors il est vivant")
        datedeces = ""

    auteur = Auteur(nom, prenom, nationalite, dateNaissance, datedeces)
    listeAuteurs.append(auteur)

############################################
############################################
############################################

def ajouter_livre(bibliothèque: list[Livre], listeAuteurs : list[Auteur]) -> None:
    """
    Fonction qui ajoute un livre à la bibliothèque
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """
    titre : str 
    titre = input("Entrez le titre du livre: ")

    auteur : Auteur
    afficher_liste_auteurs(listeAuteurs)
    choixauteur = int(input("Choisissez l'auteur que vous souhaitez (Entrez le chiffre noté sur la gauche) : ")) 
    auteur = listeAuteurs[choixauteur]

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
    titre = input("Entrez le titre du livre: ")
    trouve = False  # Indicateur pour savoir si le livre a été trouvé

    for livre in bibliothèque:
        if livre.titre == titre:
            print(livre)
            trouve = True

    if not trouve:  # Si aucun livre n'a été trouvé
        print("Le livre n'existe pas dans la bibliothèque")

############################################
############################################
############################################

if __name__ == "__main__":
    bibliothèque : list[Livre] = []
    ListeAuteurs : list[Auteur] 
    ListeAuteurs = [
    Auteur("Hugo", "Victor", "Française", "26/02/1802", "22/05/1885"),
    Auteur("Austen", "Jane", "Anglaise", "16/12/1775", "18/07/1817"),
    Auteur("Tolstoï", "Léon", "Russe", "09/09/1828", "20/11/1910"),
    Auteur("Rowling", "J.K.", "Britannique", "31/07/1965", ""),  # Auteur vivant
    Auteur("Murakami", "Haruki", "Japonais", "12/01/1949", ""),   # Auteur vivant
    Auteur("Hemingway", "Ernest", "Américaine", "21/07/1899", "02/07/1961"),
    Auteur("Coelho", "Paulo", "Brésilienne", "24/08/1947", ""),   # Auteur vivant
    Auteur("Camus", "Albert", "Française", "07/11/1913", "04/01/1960"),
    Auteur("Dumas", "Alexandre", "Française", "24/07/1802", "05/12/1870"),
    Auteur("Gaiman", "Neil", "Britannique", "10/11/1960", "")     # Auteur vivant
    ]

    choix : int

    while True:
        choix = afficher_menu()

        if choix == 1:
            afficher_bibliothèque(bibliothèque)
        if choix == 2:
            ajouter_livre(bibliothèque,ListeAuteurs)
        if choix == 3:
            ajouter_auteur(ListeAuteurs)
        if choix == 4:
            rechercher_livre(bibliothèque)
        if choix == 5:
            exit()
        if choix < 1 or choix > 5:
            print("Choix invalide")