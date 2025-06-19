if __name__ == "__main__" :
    n1 : float
    n2 : float

    n1 = float(input("Entrez un nombre entier : "))
    n2 = float(input("Entrez un autre nombre entier : "))

    if n1.is_integer() and n2.is_integer() :
        if n1>n2 :
            print(n1,">",n2)
        if n1<n2 :
            print(n1,"<",n2)
        if n1==n2 :
            print(n1,"=",n2)
    else :
        print("Les nombres doivent être entiers")
