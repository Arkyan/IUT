//
// Created by didry on 04/02/2025.
//

//Saisie d'un tableau de 10 entiers courts et afficher les 10 en décimal et affichage de leur adresse en hexadécimal


#include <stdio.h>
int main (void) {

    short tab[10];
    int i;

    for (i = 0; i < 10; i++) {
        printf("Saisissez un nombre entier court : ");
        scanf("%hd", &tab[i]);
    }

    for (i = 0; i < 10; i++) {
        printf("Le nombre %d est %hd et son adresse est %p\n", i, tab[i], &tab[i]);
    }

    return 0;
}