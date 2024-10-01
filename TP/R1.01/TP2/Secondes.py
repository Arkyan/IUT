if __name__ == "__main__" :
        seconde : int
        heure : int
        jour : int
        semaine : int
        mois : int
        annee : int
        resultat : int
        resultatannee : int
        resultatmois : int
        resultatsemaine : int
        resultatjour : int
        resultatheure : int
        resultatminute : int
        resultatseconde : int
        choix : str
        convers : int
        annee1 : int
        mois1 : int
        semaine1 : int
        jour1 : int
        heure1 : int
        minute1 : int
        seconde1 : int

        choix = str(input("Voulez vous convertir des secondes en années, mois, semaines, jours, heures et minutes ?\n Ou voulez vous convertir des années, mois, semaines, jours, heures et minutes en secondes ?\nRépondez par 'secondes' ou 'temps' : "))
        
        seconde = 1
        minute = 60 * seconde
        heure = 60 * minute
        jour = 24 * heure
        semaine = 7 * jour
        mois = 4 * semaine
        annee = 12 * mois

        if choix == "secondes" or choix == "Secondes"  or choix == "SECONDES" :      
                convers = int(input("Entrez un nombre entier de secondes : "))
                if convers < 0 :
                        print("Erreur, veuillez entrer un nombre positif")
                else : 
                        resultatannee = convers // annee
                        resultat = convers % annee
                        resultatmois = resultat // mois
                        resultat = resultat % mois                        
                        resultatsemaine = resultat // semaine
                        resultat = resultat % semaine
                        resultatjour = resultat // jour
                        resultat = resultat % jour                        
                        resultatheure = resultat // heure
                        resultat = resultat % heure
                        resultatminute = resultat // minute
                        resultat = resultat % minute
                        resultatseconde = resultat // seconde
                        resultat = resultat % seconde
                        print("Cela fait :\n", resultatannee, "année(s)\n", resultatmois, "mois\n", resultatsemaine, "semaine(s)\n", resultatjour, "jour(s)\n", resultatheure, "heure(s)\n", resultatminute, "minute(s)\n", resultatseconde, "seconde(s)\n")

        if choix == "temps" or choix == "Temps" or choix == "TEMPS" :
                annee1 = int(input("Entrez un nombre d'année(s) : "))
                mois1 = int(input("Entrez un nombre de mois : "))
                semaine1 = int(input("Entrez un nombre de semaine(s) : "))
                jour1 = int(input("Entrez un nombre de jour(s) : "))
                heure1 = int(input("Entrez un nombre d'heure(s) : "))
                minute1 = int(input("Entrez un nombre de minute(s) : "))
                seconde1 = int(input("Entrez un nombre de seconde(s) : "))
                if annee1 < 0 or mois1 < 0 or semaine1 < 0 or jour1 < 0 or heure1 < 0 or minute1 < 0 or seconde1 < 0 :
                    print("Erreur, veuillez entrer des valeurs positives")
                else :
                    resultat = annee1 * annee + mois1 * mois + semaine1 * semaine + jour1 * jour + heure1 * heure + minute1 * minute + seconde1 * seconde
                    print("Cela fait ", resultat, "seconde(s)")





 