if __name__ == "__main__":
    n = float(input("Entrez un nombre : "))

    while n < 0 or n != int(n):
        n = float(input("Entrez un nombre positif : "))

    n = int(n)

    max_value = abs(n) + abs(n)
    width = len(str(max_value))  

    for i in range(int(-n), int(n+1)):
        for j in range(int(-n), int(n+1)):
            print(f"{abs(i) + abs(j):>{width}}", end=" ")
        print()
        

