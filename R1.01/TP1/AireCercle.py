import math
 
if __name__ == "__main__":
    rayon : float
    aire : float 
    perimetre : float

    rayon = float(input("Entrez le rayon du cercle : "))
    if rayon >= 0:
        aire = math.pi * rayon ** 2
        print("L'aire du cercle est : ", aire)

        perimetre = 2 * math.pi * rayon
        print("Le périmètre du cercle est : ", perimetre)
    else:
        print("Le rayon doit être positif ou nul")



