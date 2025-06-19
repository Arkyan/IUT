def exPassage(li : list[str], val : int) -> None :
    print("modifications dans la procedure :")
    li[0] = "zero"
    val = val*2
    print(li," valeur = ",val)


if __name__ == "__main__":
    maliste : list[str]
    entier  : int
    autre : int

    maliste = ["un", "deux", "trois", "quatre"]
    entier = 10

    print("avant l'appel :")
    print(maliste," entier = ", entier)

    exPassage(maliste, entier)
    
    print("apres l'appel :")
    print(maliste," entier = ", entier)
    