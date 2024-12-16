#!/bin/bash

# Inscrire un ahérent 
# $1: option -a
# $2: nom
# $3: prénom
# $4: adresse

# Ajouter un livre à la bibliothèque
# $1: option -l
# $2: nombre exemplaires
# $3: titre
# $4: Auteur


#Vérif si le nombre d'arguments est bon
if [ $# -ne 4 ]
then
    echo "Il manque des arguments, il doit y en avoir 4"
    echo "Au format suivant: inscrire.bash -a nom prénom adresse"
    echo "Au format suivant: inscrire.bash -l nombre_exemplaires titre auteur"
    exit 1
fi

#Vérif si l'option est -a ou -l
if [ $1 = "-a" ]
then
    echo "Inscrire un adhérent"
    echo "Nom: $2"
    echo "Prénom: $3"
    echo "Adresse: $4"
elif [ $1 = "-l" ]
then
    echo "Ajouter un livre"
    echo "Nombre d'exemplaires: $2"
    echo "Titre: $3"
    echo "Auteur: $4"
else
    echo "Option inconnue"
    exit 1
fi

#################################################################################
#Vérif si un id est existant sinon commencer à 1 sinon incrémenter de 1 (MEMBRES)
if [ ! -e membres.txt ]
then
    ID=1
else
    ID=$(tail -1 membres.txt | cut -d ";" -f 1)
    ID=$(($ID + 1))
fi

#Vérif si un id est existant sinon commencer à 1 sinon incrémenter de 1 (Livres)
if [ ! -e livres.txt ]
then
    IDli=1
else
    IDli=$(tail -1 livres.txt | cut -d ";" -f 1)
    IDli=$(($IDli + 1))
fi
#################################################################################

############################################
#Vérif si le fichier membres.txt existe
if [ ! -e membres.txt ]
then
    echo "Le fichier membres.txt n'existe pas"
    exit 1
fi

#Vérif si le fichier livres.txt existe
if [ ! -e livres.txt ]
then
    echo "Le fichier livres.txt n'existe pas"
    exit 1
fi

#Inscription dans le fichier texte membres.txt
if [ $1 = "-a" ]
then
    echo -e "$ID;$2;$3;$4" >> membres.txt
elif [ $1 = "-l" ]
then
    echo -e "$IDli;$3;$4" >> livres.txt
fi

#Inscription des exemplaires dans le fichier texte exemplaires.txt
if [ $1 = "-l" ]
then
    for i in $(seq 1 $2)
    do
        echo -e "$IDli;$i;oui" >> exemplaires.txt
    done
fi
############################################