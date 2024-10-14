#un triangle rectangle de chiffres
if __name__ == "__main__":
    n : float
    i : float
    j : float

    n = float(input("Entrez un nombre : "))

    while n < 0 or n != int(n) :
        n = float(input("Entrez un nombre positif : "))

    for i in range(1, int(n+1)):
        for j in range(1, i+1):
            print(j, end="")
        print()

