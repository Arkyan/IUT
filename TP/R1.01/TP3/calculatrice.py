if __name__ == "__main__" :
        operande1 : float
        operande2 : float
        resultat : float
        operateur : str
        operande1 = float(input("Entrez un premier nombre réel : "))
        operateur = str(input("Entrez un opérateur : "))
        operande2 = float(input("Entrez un autre nombre réel : "))
        if operateur == "+" :
                resultat = operande1 + operande2
                print("Le résultat est : ", resultat)
        if operateur == "-" :
                resultat = operande1 - operande2
                print("Le résultat est : ", resultat)
        if operateur == "*" :
                resultat = operande1 * operande2
                print("Le résultat est : ", resultat)
        if operateur == "/" :
                if operande2 == 0 :
                        print("Erreur, la division par zéro est impossible")
                else :
                    resultat = operande1 / operande2
                    print("Le résultat est : ", resultat)
        if operateur != "+" and operateur != "-" and operateur != "*" and operateur != "/" :
                print("Erreur, opérateur inconnu")

