#!/bin/bash

#script vérifiant les emprunts datant de plus d'un moins et les affichant

# Vérification du nombre d'arguments
if [ $# -ne 0 ]; then
    echo "Erreur: Nombre d'arguments incorrect"
    exit 1
fi

# Vérification de l'existence du fichier
if [ ! -f "emprunts.txt" ]; then
    echo "Erreur: Fichier emprunts.txt introuvable"
    exit 1
fi

# Parcourir les emprunts
while IFS= read -r ligne; do
    # Récupération de la date d'emprunt
    dateEmprunt=$(echo "$ligne" | cut -d ";" -f 4)
    jouremprunt=$(echo $dateEmprunt | cut -d ' ' -f 1)
    moisemprunt=$(echo $dateEmprunt | cut -d ' ' -f 2)
    anneemprunt=$(echo $dateEmprunt | cut -d ' ' -f 3)

    dateCourante=$(date '+%-d %-m %Y %X')
    #Transformation de la date courante dans ce format jour_mois_annee_heure:minute:seconde
    dateCourante=$(echo $dateCourante | sed 's/ /_/g')

    # Conversion de la date d'emprunt en format timestamp
    dateEmpruntTimestamp=$(date -d "$anneemprunt-$moisemprunt-$jouremprunt" +%s 2>/dev/null)

    #Utilisation de comptemps.bash pour comparer les dates
    bash comptemps.bash $jouremprunt $moisemprunt $anneemprunt $dateCourante > /dev/null

    # Récupération du code de retour
    codeRetour=$?

    # Si la date d'emprunt est supérieure à un mois donc code retour = 1 ou 2
    if [ $codeRetour -eq 1 ] || [ $codeRetour -eq 2 ]; then
        echo "$ligne"
    fi

done < "emprunts.txt"

