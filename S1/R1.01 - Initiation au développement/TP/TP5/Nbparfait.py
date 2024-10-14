def nbParfait( n : int) -> int:
    """
    Renvoie la somme des diviseurs de n
    
    :param n: un entier
    
    :return: la somme des diviseurs de n
    """

    somme = 0
    for i in range(1, n-1) :
        if n % i == 0:
            somme += i
    return somme 


if __name__ == "__main__":
    i : int
    n : float
    a : int

    n = int(input("Entrez un nombre : "))

    while n < 0:
        n = int(input("Entrez un nombre positif : "))

    for i in range(1, n+1):
        a = nbParfait(i)
        if a == i:
            print(i, "est un nombre parfait")