if __name__ == "__main__" :
        operande1 : float
        operande2 : float
        resultat : float
        operateur : str
        operande1 = float(input("Entrez un nombre : "))
        operateur = str(input("Entrez un opérateur : "))
        operande2 = float(input("Entrez un autre nombre : "))
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
                        print("Erreur, division par zéro impossible")
                else :
                    resultat = operande1 / operande2
                    print("Le résultat est : ", resultat)
