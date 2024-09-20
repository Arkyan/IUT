if __name__ =="__main__" :
    longueurpièce : int
    hauteurpièce : int
    longueurcarrelage : int
    hauteurcarrelage : int
    joint : int
    nombrecarreauxlongueur : int
    nombrecarreauxlargeur : int 
    nombrecarreauxtotal : int

    longueurpièce = int(input("Entrez la longueur de la pièce : "))
    hauteurpièce = int(input("Entrez la hauteur de la pièce : "))
    longueurcarrelage = int(input("Entrez la longueur du carrelage : "))
    hauteurcarrelage = int(input("Entrez la hauteur du carrelage : "))
    joint = int(input("Entrez la largeur des joints : "))

    if longueurpièce > 0 and hauteurpièce > 0 and longueurcarrelage > 0 and hauteurcarrelage > 0 :
        if longueurpièce > longueurcarrelage + 2*joint and hauteurpièce > hauteurcarrelage + 2*joint :
            nombrecarreauxlongueur = longueurpièce // (longueurcarrelage + joint)
            nombrecarreauxlargeur = hauteurpièce // (hauteurcarrelage + joint)
            nombrecarreauxtotal = nombrecarreauxlongueur * nombrecarreauxlargeur
            print("Le nombre de carreaux nécessaires est : ", nombrecarreauxtotal)
        else :
            print("il y a une erreur dans les dimensions")

    else : 
        print("il y a une erreur dans les dimensions")



    