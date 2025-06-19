if __name__ == "__main__":
    n = float(input("Entrez un nombre : "))

    while n < 1 or n != int(n):
        n = float(input("Entrez un nombre positif : "))

    n = int(n)
    width = len(str(n))  # La largeur maximale en fonction de n

    for i in range(1, n+1):
        for j in range(1, i+1):
            print(f"{j:>{width}}", end=" ")  # On formate chaque nombre pour qu'il ait la même largeur
        print()

    