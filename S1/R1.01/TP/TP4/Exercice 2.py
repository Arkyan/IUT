#test si premier ou non
if __name__ == '__main__':
    n : int
    i : int
    premier : bool
    premier = True


    n = int(input("Entrez un nombre: "))
    while n < 0 :
        n = int(input("Entrez un nombre entier positif: "))


    if n == 0:
        print(n,"n'est pas premier :(")
    else :
        if n == 1:
            print(n,"n'est pas premier :(")
            premier = False
        else :
            if n == 2:
                print(n,"est premier :)")
            else :
                if n >= 3:
                    i = 2
                    while i <= n-1 and n % i != 0:
                        i = i + 1
                    if i == n:
                        print(n,"est premier :)")
                    else :
                        print(n,"n'est pas premier :(")
                        premier = False

    if premier == False :
        print("Il est divisible par: 1", end=", ")
        for i in range(2, n):
            if n % i == 0:
                print(i, end=", ")
        print(n)


