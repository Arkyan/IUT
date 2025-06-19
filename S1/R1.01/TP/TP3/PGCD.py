if __name__ == "__main__" :
        a : float
        b : float
    
        a = float(input("Entrez un nombre : "))
        b = float(input("Entrez un autre nombre : "))
        while a != int(a) or b != int(b) :
            print("Erreur, les nombres doivent être des entiers")
            a = float(input("Entrez un nombre ENTIER: "))
            b = float(input("Entrez un autre nombre ENTIER : "))
        while a <= 0 or b <= 0 :
            print("Erreur, les nombres ne peuvent pas être nuls ou négatifs")
            a = float(input("Entrez un nombre POSITIF et NON NUL : "))
            b = float(input("Entrez un autre nombre POSITIF NON NUL : "))
        while a != b :
            if a > b :
                a = a - b
            else :
                b = b - a
        print("Le PGCD est : ", a)


