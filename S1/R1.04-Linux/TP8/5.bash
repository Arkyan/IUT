#Script nommé copain.sh qui permet de savoir qui est connecté sur la machine sur quel numéro et quels droits

#!/bin/bash

#Vérif 0 argument
if [ $# -ne 0 ]
then
    echo "Usage: $0"
    exit 1
fi

#Affichage
echo "Utilisateur connecté sur la machine:"
who | awk '{print $1 " " $5 " " $6}'
