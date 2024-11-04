def power(a : float, n : int) -> float :
    # Cas de base : a^0 = 1
    if n == 0:
        return 1
    # Si n est pair
    if n % 2 == 0:
        temp = power(a, n // 2)
        return temp * temp
    # Si n est impair
    else:
        temp = power(a, (n - 1) // 2)
        return a * temp * temp



if __name__ == "__main__":
    a : float
    n : float

    a = float(input("Veuillez saisir un nombre : "))
    n = float(input("Veuillez saisir la puissance : "))
    while n < 0 or n != int(n):
        n = int(input("Veuillez saisir un entier positif pour la puissance : "))

    if a == 0 and n == 0:
        print("0 puissance 0 est indéfini")
    else:
        print(a, "puissance", n, "=", power(a, int(n)))

