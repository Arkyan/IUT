def sommeRiterative(n : int) -> int :
    res : int 
    i : int
    res = 0
    for i in range (0,n+1) :
        res = res + i
    return res

def sommeRecur(n : int) -> int :
    if n == 1:
        return 1
    else :
        return n + sommeRecur(n-1)
    
if __name__ == "__main__" :
    n : float
    n = float(input("Veuillez saisir un entier positif : "))

    while n<0 or n != int(n):
        n = float(input("Veuillez saisir un entier positif : "))

    print("La méthode itérative : ", sommeRiterative(int(n)))
    print("La méthode récursive : ", sommeRecur(int(n)))