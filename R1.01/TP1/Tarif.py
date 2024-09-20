if __name__ == "__main__":
    age : int
    prix : float

    age = int(input("Entrez votre âge : "))
    prix = float(input("Entrez le prix de base : "))
    if age > 0 and prix > 0:
        if age < 18 :
            prix = prix * 0.5
        if age >= 19 and age <= 27 :
            prix = prix * 0.8
        print("Le prix à payer est : ", prix)
    else:
        print("L'âge et le prix doivent être positifs")
