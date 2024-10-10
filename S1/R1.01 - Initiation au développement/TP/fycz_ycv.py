if __name__ == "__main__" :
    i : int
    nbr : float
    const : int
    premier : bool

    premier = True

    nbr = float(input("Saisissez un entier : "))
    while nbr < 0 or nbr != int(nbr):
        print("Rentrez une autre valeur > 0")
        nbr = float(input("Saisir un entier : "))

    const = 0
    for i in range(1,int(nbr+1)) :
        if nbr%i == 0 :
            const += 1
    if const == 2 :
        print(int(nbr), "est premier")
    else : 
        print(int(nbr), "n'est pas premier")
        premier = False

    if nbr == 0 or nbr == 1 :
        print("Il est uniquement divisible par: 1")
    else :
        if premier == False :
            print("Il est divisible par: 1", end=", ")
            for i in range(2, int(nbr)):
                if int(nbr) % i == 0:
                    print(i, end=", ")
            print(int(nbr))



