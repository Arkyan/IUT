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

    n = float(input("Entrez un nombre : "))

    while n < 0 or n != int(n) :
        n = float(input("Entrez un nombre positif : "))

    if n >= 6 : 
        for i in range(1, int(n+1)):
            a = nbParfait(i)
            if a == i:
                print(i, "est un nombre parfait")
    else:
        print("Il n'y a pas de nombre parfait inférieur à 6")



