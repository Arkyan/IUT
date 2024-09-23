if __name__ =="__main__" :
    annee : float
    mois : float
    semaine : float
    jour : float
    heure : float
    minute : float
    seconde : float

    annee = float(input("Entrez le nombre d'années : "))
    if annee < 0:
        print("Le nombre d'années doit être positif ou nul")
    else :
        mois = annee * 12
        semaine = annee * 52
        jour = annee * 365
        heure = annee * 8760
        minute = annee * 525600
        seconde = annee * 31536000
        print("Le nombre de mois est : ", mois)
        print("Le nombre de semaines est : ", semaine)
        print("Le nombre de jours est : ", jour)
        print("Le nombre d'heures est : ", heure)
        print("Le nombre de minutes est : ", minute)
        print("Le nombre de secondes est : ", seconde)