#Programme calcule la racine carrée d’un nombre réel :
import math

if __name__ =="__main__" :
    nombre : float
    racine : float
    saisie : str
    saisie= input("Saisir un nombre :")
    nombre = float(saisie)
    racine = math.sqrt(nombre) #Attention : pb si nombre < 0
    print("La racine carrée de :", nombre, " est ", racine)