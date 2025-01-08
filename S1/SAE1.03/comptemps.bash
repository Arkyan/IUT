#!/bin/bash

#Script comparant la date courante à une date donnée en argument

#$1 Jour dans le mois
#$2 Mois
#$3 Année
#$4 Date courante (format : jour mois année heure:minute:seconde)

# Vérif si le nombre d'arguments est bon
if [ $# -ne 4 ]; then
    echo "Il manque des arguments, il doit y en avoir 4"
    echo "Au format suivant: comptemps.bash jour mois année date_courante"
    exit 1
fi

# Vérif si le jour est compris entre 1 et 31
if [ $1 -lt 1 ] || [ $1 -gt 31 ]; then
    echo "Le jour doit être compris entre 1 et 31"
    exit 1
fi

# Vérif si le mois est compris entre 1 et 12
if [ $2 -lt 1 ] || [ $2 -gt 12 ]; then
    echo "Le mois doit être compris entre 1 et 12"
    exit 1
fi

# Vérif si l'année est supérieure à 0
if [ $3 -le 0 ]; then
    echo "L'année doit être supérieure à 0"
    exit 1
fi

# Vérif si la date courante est au bon format


# Récupération des arguments
jour=$1
mois=$2
annee=$3
dateCourante=$4

# Récupération de la date courante
jourCourant=$(echo $dateCourante | cut -d '_' -f 1)
moisCourant=$(echo $dateCourante | cut -d '_' -f 2)
anneeCourant=$(echo $dateCourante | cut -d '_' -f 3)

# Conversion des dates en format timestamp pour comparaison
dateArgTimestamp=$(date -d "$annee-$mois-$jour" +%s 2>/dev/null)
dateCouranteTimestamp=$(date -d "$anneeCourant-$moisCourant-$jourCourant" +%s 2>/dev/null)

# Vérification de la validité des dates
if [ -z "$dateArgTimestamp" ] || [ -z "$dateCouranteTimestamp" ]; then
    echo "La date fournie n'est pas valide"
    exit 1
fi

# Comparaison des dates
if [ "$dateArgTimestamp" -ge "$dateCouranteTimestamp" ]; then
    echo "0" # La date est postérieure ou égale
    exit 0
fi

# Calcul des différences en mois et années
diffSeconds=$((dateCouranteTimestamp - dateArgTimestamp))
diffDays=$((diffSeconds / 86400))
diffMonths=$((diffDays / 30))
diffYears=$((diffDays / 365))

if [ "$diffYears" -ge 1 ]; then
    echo "1" # La date est antérieure de plus d'un an
    exit 1
elif [ "$diffMonths" -ge 1 ]; then
    echo "2" # La date est antérieure de plus d'un mois et moins d'un an
    exit 2
else
    echo "3" # La date est antérieure de moins d'un mois
    exit 3
fi