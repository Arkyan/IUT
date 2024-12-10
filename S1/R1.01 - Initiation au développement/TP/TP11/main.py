import pickle
from time import sleep
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
    print("5. Exporter la bibliothèque dans un fichier texte")
    print("6. Importer la bibliothèque depuis un fichier texte")
    print("7. Quitter")

    choix =int(input("Entrez votre choix: "))

    return choix

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

def ajouter_livre(nom_fichier: str, listeAuteurs: list[Auteur]) -> None:
    """
    Fonction qui ajoute un livre à la bibliothèque existante dans un fichier binaire.
    Si le fichier contient déjà des livres, ils seront conservés.
    """
    # Charger la bibliothèque existante
    bibliothèque = lire_fichier_binaire(nom_fichier)

    # Obtenir les informations du nouveau livre
    titre = input("Entrez le titre du livre: ")
    afficher_liste_auteurs(listeAuteurs)
    choixauteur = int(input("Choisissez l'auteur que vous souhaitez (Entrez le chiffre noté sur la gauche) : ")) 
    auteur = listeAuteurs[choixauteur]
    annee = int(input("Entrez l'année de publication: "))
    nbpages = int(input("Entrez le nombre de pages: "))

    livre = Livre(titre, auteur, annee, nbpages)
    bibliothèque.append(livre)

    # Réécriture complète de la bibliothèque dans le fichier
    try:
        with open(nom_fichier, "wb") as file:
            pickle.dump(bibliothèque, file)
        print(f"Le livre '{titre}' a été ajouté et sauvegardé avec succès.")
    except IOError:
        print("Erreur lors de la sauvegarde de la bibliothèque.")

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

def verification_fichierbinaire_existe(fichier: str) -> bool:
    """
    Vérifie si un fichier existe, sinon le crée et l'initialise avec une valeur par défaut.
    
    Args:
        fichier (str): Le nom du fichier.
    
    Returns:
        bool: True si le fichier existe ou a été créé avec succès, False sinon.
    """
    try:
        # Tente d'ouvrir le fichier en lecture
        with open(fichier, "rb"):
            return True
    except FileNotFoundError:
        # Si le fichier n'existe pas, le créer et l'initialiser
        try:
            with open(fichier, "wb") as file:
                pickle.dump([], file)  # Initialisation avec une liste vide
            return True
        except IOError:
            return False
    
############################################

def sauvegarde_biblio_binaire (bibliothèque : list[Livre], fichier : str) -> None :
    """
    Fonction qui sauvegarde une bibliothèque dans un fichier binaire
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
        fichier (str): le nom du fichier binaire
    Returns:
        None
    """

    with open(fichier, "wb") as file:
        pickle.dump(bibliothèque, file)

############################################
def export_binaire_texte(fichier_texte: str, fichier_binaire: str) -> None:
    """
    Fonction qui lit un fichier binaire, exporte son contenu dans un fichier texte
    
    Args:
        bibliothèque (list[Livre]): La liste des livres de la bibliothèque.
        fichier_texte (str): Le nom du fichier texte où exporter la bibliothèque.
        fichier_binaire (str): Le nom du fichier binaire à lire et vider après l'export.
    
    Returns:
        None
    """
    bibliothèque : list[Livre]

    try:
        # Lire le contenu du fichier binaire (temp.bin)
        try:
            with open(fichier_binaire, "rb") as bin_file:
                bibliothèque = pickle.load(bin_file)
        except FileNotFoundError:
            print(f"Le fichier '{fichier_binaire}' n'existe pas. Aucun contenu à importer.")
            bibliothèque = []

        # Création et écriture dans le fichier texte (écrasé à chaque exécution)
        with open(fichier_texte, "w", encoding="utf-8") as file:  # Mode 'w' pour écraser le fichier
            for livre in bibliothèque:
                # Écrire chaque livre dans une ligne séparée
                file.write(f"Titre -> {livre.titre};Auteur -> {livre.auteur};Année de publication -> {livre.annee};Nombre de pages -> {livre.nbPages}\n")
                
        print(f"La bibliothèque a été exportée avec succès dans le fichier '{fichier_texte}'.")

    except IOError:
        print(f"Erreur : Impossible de créer ou d'écrire dans le fichier '{fichier_texte}'.")


def import_bibliotheque_texte(bibliothèque : list[Livre] ,fichierimport : str, fichierbinaire: str) -> None:
    """
    Fonction qui importe une bibliothèque depuis un fichier texte et l'ajoute à la bibliothèque existante.
    Args:
        fichierimport (str): Le nom du fichier texte à importer.
        fichierbinaire (str): Le nom du fichier binaire où ajouter les livres importés.
    Returns:
        None
    """
    # Charger la bibliothèque existante
    bibliothèque = lire_fichier_binaire(fichierbinaire)

    try:
        with open(fichierimport, "r", encoding="utf-8") as file:
            lignes = file.readlines()

            for ligne in lignes:
                # Découper la ligne en fonction des séparateurs
                elements = ligne.split(";")
                titre = elements[0].split("->")[1].strip()
                auteur_details = elements[1].split("->")[1].strip().split("|")
                nom = auteur_details[0]
                prenom = auteur_details[1]
                nationalite = auteur_details[2]
                dateNaissance = auteur_details[3]
                dateDeces = auteur_details[4] if len(auteur_details) > 4 else ""
                auteur = Auteur(nom, prenom, nationalite, dateNaissance, dateDeces)
                annee = int(elements[2].split("->")[1].strip())
                nbpages = int(elements[3].split("->")[1].strip())

                # Ajouter le livre à la bibliothèque
                bibliothèque.append(Livre(titre, auteur, annee, nbpages))

        # Réécriture complète de la bibliothèque dans le fichier binaire
        with open(fichierbinaire, "wb") as bin_file:
            pickle.dump(bibliothèque, bin_file)

        print(f"La bibliothèque a été importée avec succès depuis le fichier '{fichierimport}'.")

    except FileNotFoundError:
        print(f"Le fichier '{fichierimport}' n'existe pas.")
    except IOError:
        print(f"Erreur lors de la lecture du fichier '{fichierimport}'.")

def lire_fichier_binaire(fichier: str) -> list[Livre]:
    """
    Fonction qui lit un fichier binaire contenant la bibliothèque complète.
    """
    try:
        with open(fichier, "rb") as file:
            bibliothèque = pickle.load(file)
            return bibliothèque
    except FileNotFoundError:
        print(f"Le fichier '{fichier}' n'existe pas. Une nouvelle bibliothèque sera créée.")
        return []
    except EOFError:
        print(f"Le fichier '{fichier}' est vide.")
        return []
    except IOError:
        print(f"Erreur lors de la lecture du fichier '{fichier}'.")
        return []
    

def afficher_bibliotheque(fichierbin : str) -> None:
    """
    Fonction qui affiche l'ensemble des livres de la bibliothèque
    Args:
        bibliothèque (list[Livre]): la liste des livres de la bibliothèque
    Returns:
        None
    """
    bibliothèque = lire_fichier_binaire(fichierbin)
    if not bibliothèque:
        print("La bibliothèque est vide")
        return

    print("Bibliothèque :")
    for livre in bibliothèque:
        print("---------------------------------")
        print(livre)
    sleep(5)

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

    while True : 
        sleep(2)
        print("\033c", end="")
        verification_fichierbinaire_existe('bibliothèque.bin')
        choix = afficher_menu()

        if choix == 1: 
            afficher_bibliotheque('bibliothèque.bin')
        if choix == 2:
            ajouter_livre('bibliothèque.bin',ListeAuteurs)
        if choix == 3:
            ajouter_auteur(ListeAuteurs)
        if choix == 4:
            rechercher_livre(bibliothèque)
        if choix == 5:
            export_binaire_texte('bibliothèque.txt', 'bibliothèque.bin')
        if choix == 6:
            import_bibliotheque_texte(bibliothèque, 'bibliothèque.txt', 'bibliothèque.bin')
        if choix == 7:
            sauvegarde_biblio_binaire(bibliothèque, 'bibliothèque.bin')
            exit()
        if choix < 1 or choix > 7:
            print("Choix invalide")