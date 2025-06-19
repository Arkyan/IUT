if __name__ == "__main__" :
        jour : float
        mois : float
        annee : float
        bissextile : bool
        bissextile = False
        jour = float(input("Entrez le jour : "))
        mois = float(input("Entrez le mois : "))
        annee = float(input("Entrez l'année : "))

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
                else :
                    print("La date est valide")
            else :
                if jour > 28 :
                    print("Erreur, le mois de février ne peut pas avoir plus de 28 jours")
                else :
                    print("La date est valide")
        else :
            if mois == 4 or mois == 6 or mois == 9 or mois == 11 :
                if jour > 30 :
                    print("Erreur, ce mois ne peut pas avoir plus de 30 jours")
                else :
                    print("La date est valide")
            else :
                if jour > 31 :
                    print("Erreur, ce mois ne peut pas avoir plus de 31 jours")
                else :
                    print("La date est valide")