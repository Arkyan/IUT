#Fibonacci
"""
if __name__ == "__main__":
    i : int
    n : float  

    n = float(input("Entrez un entier: "))
    while n < 0 or n != int(n):
        n = float(input("Entrez un entier positif: "))

    un = 0
    un1 = 1
    if n == 0:
        print("U 0 = 0")
    else :
        if n == 1:
            print("U 0 = 0")
            print("U 1 = 1")
        else :
            if n >= 2 : 
                print("U 0 = 0")
                print("U 1 = 1")
                for i in range(2,int(n+1)):
                    un2 = un1 + un
                    print("U",i,"=",un2)
                    un = un1
                    un1 = un2
"""
################################################################
################################################################
################################################################
#Fibonacci borné
if __name__ == "__main__":
    i : int
    bornesup : float

    bornesup = float(input("Entrez un entier: "))

    while bornesup < 0 or bornesup != int(bornesup):
        bornesup = float(input("Entrez un entier positif: "))

    un = 0
    un1 = 1

    if bornesup == 0:
        print("U 0 = 0")
    else :
        if bornesup == 1:
            print("U 1 = 1")
        else :
            if bornesup >= 2 : 
                print("U 0 = 0")
                print("U 1 = 1")
                i = 2
                while un1 + un <= bornesup:
                    un2 = un1 + un
                    print("U",i,"=",un2)
                    un = un1
                    un1 = un2
                    i = i + 1
