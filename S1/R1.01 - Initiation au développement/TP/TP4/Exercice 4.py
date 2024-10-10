#Saisir une date et obtenir le jour suivant 

if __name__ == '__main__':
    jour : float
    mois : float
    annee : float
    bissextile : bool
    nbjours : int
    jour = int(input("Entrez un jour: "))
    mois = int(input("Entrez un mois: "))
    annee = int(input("Entrez une année: "))
    bissextile = False
    nbjours = 0  
    valide = True
    
    while jour != int(jour) or mois != int(mois) or annee != int(annee) :
        print("Erreur, les nombres doivent être des entiers")
        jour = float(input("Entrez le jour : "))
        mois = float(input("Entrez le mois : "))
        annee = float(input("Entrez l'année : "))
    while jour < 1 or jour > 31 :
        print("Erreur, le jour doit être compris entre 1 et 31")
        jour = int(input("Entrez le jour : "))
    while mois < 1 or mois > 12 :
        print("Erreur, le mois doit être compris entre 1 et 12")
        mois = int(input("Entrez le mois : "))
            
    #Vérification si l'année est bissextile et si la date est valide avec une variable
    if annee % 4 == 0 :
        if annee % 100 != 0 :
            bissextile = True
        else :
            if annee % 400 == 0 :
                bissextile = True
    if mois == 2 :
        if bissextile :
            if jour > 29 :
                print("Erreur, le mois de février ne peut pas avoir plus de 29 jours")
                valide = False
            else :
                nbjours = 29
        else :
            if jour > 28 :
                print("Erreur, le mois de février ne peut pas avoir plus de 28 jours")
                valide = False
            else :
                nbjours = 28
    else :
        if mois == 4 or mois == 6 or mois == 9 or mois == 11 :
            if jour > 30 :
                print("Erreur, ce mois ne peut pas avoir plus de 30 jours")
                valide = False
            else :
                nbjours = 30
        else :
            if jour > 31 :
                print("Erreur, ce mois ne peut pas avoir plus de 31 jours")
                valide = False
            else :
                nbjours = 31

    #Calcul du jour suivant
    if valide :
        if jour == nbjours :
            jour = 1
            if mois == 12 :
                mois = 1
                annee = annee + 1
            else :
                mois = mois + 1
        else :
            jour = jour + 1
        print("Le jour suivant est le",jour,"/",mois,"/",annee)
    else :
        print("La date n'est pas valide")
