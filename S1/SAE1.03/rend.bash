#!/bin/bash

#Script qui prend en compte 2 arguments et qui vérifie leur validité
#Puis contrôle si l'emprunt est bien enregistré dans le fichier
#Si l'emprunt est enregistré, le script supprime la ligne dans le fichier
#Et modifie le fichier de stock en ajoutant la ligne de l'exemplaire

#Vérification du nombre d'arguments
if [ $# -ne 2 ]; 
then
    echo "Erreur: Nombre d'arguments incorrect"
    exit 1
fi

#Vérification de l'existence des fichiers
if [ ! -f "emprunts.txt" ]; 
then
    echo "Erreur: Fichier emprunts.txt introuvable"
    exit 1
fi

if [ ! -f "exemplaires.txt" ]; 
then
    echo "Erreur: Fichier exemplaires.txt introuvable"
    exit 1
fi



#Récupération des numéros d'adhérent et de livre et d'exemplaire
idAdh=$(grep "$1;" membres.txt | cut -d ";" -f 1)
idLivre=$(grep "$2;" livres.txt | cut -d ";" -f 1)

#Récupération de l'exemplaire
#Il doit vérifier si l'exemplaire est disponible et prendre le premier qu'il est
idexemplaire=$(grep "$idLivre;" exemplaires.txt | grep "non" | head -1 | cut -d ";" -f 2)

#Vérification de la validité des arguments
if ! grep -q "$idAdh;$idexemplaire" emprunts.txt; 
then
    echo "Erreur: Emprunt non enregistré"
    exit 1
fi

#Suppression de la ligne dans le fichier emprunts.txt
sed -i "/$idAdh;$idexemplaire/d" emprunts.txt

#Ajout de la ligne dans le fichier stock.txt
sed -i "s/$idLivre;$idexemplaire;non/$idLivre;$idexemplaire;oui/" exemplaires.txt
echo "Emprunt rendu avec succès"
exit 0