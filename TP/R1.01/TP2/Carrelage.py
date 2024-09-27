if __name__ =="__main__" :
    longueurpièce : float
    hauteurpièce : float
    longueurcarrelage : float
    hauteurcarrelage : float
    joint : float
    nombrecarreauxlongueur : float
    nombrecarreauxlargeur : float 
    nombrecarreauxtotal : float

    longueurpièce = float(input("Entrez la longueur de la pièce : "))
    hauteurpièce = float(input("Entrez la hauteur de la pièce : "))
    longueurcarrelage = float(input("Entrez la longueur du carrelage : "))
    hauteurcarrelage = float(input("Entrez la hauteur du carrelage : "))
    joint = float(input("Entrez la largeur des joints : "))
    if longueurpièce.is_integer() and hauteurpièce.is_integer() and longueurcarrelage.is_integer() and hauteurcarrelage.is_integer() and joint.is_integer() :
        if longueurpièce > 0 and hauteurpièce > 0 and longueurcarrelage > 0 and hauteurcarrelage > 0 :
            if longueurpièce > longueurcarrelage + 2*joint and hauteurpièce > hauteurcarrelage + 2*joint :
                nombrecarreauxlongueur = longueurpièce // (longueurcarrelage + joint)
                nombrecarreauxlargeur = hauteurpièce // (hauteurcarrelage + joint)
                nombrecarreauxtotal = nombrecarreauxlongueur * nombrecarreauxlargeur
                print("Le nombre de carreaux nécessaires est : ", nombrecarreauxtotal)
            else :
                print("Les dimensions de la pièce doivent être supérieures à celles du carrelage")
    
        else : 
            print("Les dimensions doivent être positives")
    else :
        print("Les dimensions doivent être entières")