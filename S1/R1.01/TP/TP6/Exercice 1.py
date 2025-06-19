from date import *

def nbrannéeentière(j1 : int, j2 : int, m1 : int, m2 : int, a1 : int, a2 :int) -> int : 
    """
    Renvoie le nombre d'années entières entre deux dates
    
    :param j1: le jour de naissance
    :param j2: le jour de la date de projection
    :param n1: le mois de naissance
    :param n2: le mois de la date de projection
    :param a1: l'année de naissance
    :param a2: l'année de la date de projection
    
    :return: le nombre d'années entières entre deux dates
    """
    age : int
    age = a2 - a1

    if age < 0 :
        age = -1
        print("La personne n'est pas encore née.")
        return age
    if ((m2<m1) or (m2==m1 and j2<j1)) :
        age -= 1
    
    print("La personne est agée de :" ,age ,"ans.")
    return age

def qualification(age : int) -> str :
    """
    Renvoie la qualification de l'âge
    
    :param age: l'âge de la personne
    
    :return: la qualification de l'âge
    """
    
    qualite : str
    qualite = " "

    if age < 0 :
        print("Problème de saisi")
        return ""
    if age >= 0 and age < 18 :
        qualite = qualite + "mineure"
    else :
        qualite = qualite + "majeure"

    if ((age>=20) and (age<30)) :
        qualite = qualite + " et vingtenaire"
    else :
        if ((age>=30) and (age<40)) :
            qualite = qualite + " et trentenaire"
        else :
            if ((age>=40) and (age<50)) :
                qualite = qualite + " et quarantenaire"
            else :
                if ((age>=50) and (age<60)) :
                    qualite = qualite + " et cinquantenaire"
                else :
                    if ((age>=60) and (age<70)) :
                        qualite = qualite + " et sexagénaire"

    if age >= 64 : 
        qualite = qualite + " et retraité"

    qualite = qualite + "."

    return qualite
 
###########################################################
#               Programme principal                       #
###########################################################

if __name__ == "__main__":
    j1 : int
    j2 : int
    m1 : int
    m2 : int
    a1 : int
    a2 : int
    age : int
    qualite : str

    j1 = int(input("Entrez le jour de naissance : "))
    m1 = int(input("Entrez le mois de naissance : "))
    a1 = int(input("Entrez l'année de naissance : "))
    j2 = int(input("Entrez le jour de la date de projection : "))
    m2 = int(input("Entrez le mois de la date de projection : "))
    a2 = int(input("Entrez l'année de la date de projection : "))

    while not(VerifierDate(j1,m1,a1)) :
        j1 = int(input("Problème de saisi, Ré-entrez le jour de naissance : "))
        m1 = int(input("Problème de saisi, Ré-entrez le mois de naissance : "))
        a1 = int(input("Problème de saisi, Ré-entrez l'année de naissance : "))

    while not(VerifierDate(j2,m2,a2)) :
        j2 = int(input("Problème de saisi, Ré-entrez le jour de la date de projection : "))
        m2 = int(input("Problème de saisi, Ré-entrez le mois de la date de projection : "))
        a2 = int(input("Problème de saisi, Ré-entrez l'année de la date de projection : "))

    age = nbrannéeentière(j1,j2,m1,m2,a1,a2)
    qualite = qualification(age)
    print("La personne est", qualite)