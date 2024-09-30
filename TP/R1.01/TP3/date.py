if __name__ == "__main__" :
        jour : int
        mois : int
        annee : int
        bissextile : bool
        bissextile = False
        jour = int(input("Entrez le jour : "))
        mois = int(input("Entrez le mois : "))
        annee = int(input("Entrez l'année : "))
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