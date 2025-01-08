#!/bin/bash

#Script qui a 2 arguments : Nom adhérent et titre du livre 
#Vérif si le nombre d'arguments est bon
# $1 : nom adhérent
# $2 : titre du livre



if [ $# -ne 2 ]
then
    echo "Il manque des arguments, il doit y en avoir 2"
    echo "Au format suivant: demande.bash nom_adhérent titre_livre"
    exit 1
fi

#Vérif si le nom de l'adhérent est présent dans le fichier membres.txt
if [ ! -f membres.txt ]
then
    echo "Le fichier membres.txt n'existe pas"
    exit 1
fi

if [ $(grep -c "$1;" membres.txt) -eq 0 ]
then
    echo "Le nom $1 n'est pas dans le fichier membres.txt"
    exit 1
else 
    echo "Le nom $1 est dans le fichier membres.txt"
fi

#Vérif si le titre est présent dans le fichier livres.txt
if [ ! -f livres.txt ]
then
    echo "Le fichier livres.txt n'existe pas"
    exit 1
fi

if [ $(grep -c "$2;" livres.txt) -eq 0 ]
then
    echo "Le titre $2 n'est pas dans le fichier livres.txt"
    exit 1
else 
    echo "Le titre $2 est dans le fichier livres.txt"
fi




#Récupération des numéros d'adhérent et de livre et d'exemplaire
idAdh=$(grep "$1;" membres.txt | cut -d ";" -f 1)
idLivre=$(grep "$2;" livres.txt | cut -d ";" -f 1)

#Récupération de l'exemplaire
#Il doit vérifier si l'exemplaire est disponible et prendre le premier qu'il est
idexemplaire=$(grep "$idLivre;" exemplaires.txt | grep "oui" | head -1 | cut -d ";" -f 2)

#TESTTTTTTTT
echo idAdh : $idAdh
echo idLivre : $idLivre
echo idexemplaire : $idexemplaire
date=$(date '+%-d %-m %Y %X')
echo date : $date
##################

#Vérif si le fichier exemplaires.txt existe / Vérif si le livre est disponible
if [ ! -f exemplaires.txt ]
then
    echo "Le fichier exemplaires.txt n'existe pas"
    exit 1
fi

if [ $(grep -c "$idexemplaire" exemplaires.txt) -eq 0 ]
then
    echo "Le livre $2 n'est pas disponible"
    exit 1
else 
    echo "Le livre $2 est disponible"
fi

#Vérif si le fichier emprunts.txt existe
if [ ! -e emprunts.txt ]
then
    echo "Le fichier emprunts.txt n'existe pas"
    exit 1
fi

#Vérif si l'emprunt est déjà enregistré
if [ $(grep -c "$idAdh;$idLivre;$idexemplaire" emprunts.txt) -ne 0 ]
then
    echo "Il n'y a plus d'exemplaire disponible"
    exit 1
else 
    echo "L'emprunt n'est pas enregistré"
fi

#Enregistrement de l'emprunt
echo -e "$idAdh;$idLivre;$idexemplaire;$date" >> emprunts.txt

#Modification de la disponibilité du livre
sed -i "s/$idLivre;$idexemplaire;oui/$idLivre;$idexemplaire;non/" exemplaires.txt
