if __name__ == "__main__" :
        a : int
        b : int
    
        a = int(input("Entrez un nombre : "))
        b = int(input("Entrez un autre nombre : "))
        while a != b :
            if a > b :
                a = a - b
            else :
                b = b - a
        print("Le PGCD est : ", a)