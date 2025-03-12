//
// Created by didry on 18/02/2025.
//

#include <stdio.h>

int main() {
    char *couleur[] = {"rouge", "vert", "bleu", "blanc", "noir", "orange", NULL};

    int i = 0;

    // 1. Afficher les couleurs avec %s
    printf("Couleurs :\n");
    while (couleur[i] != NULL) {
        printf("%s\n", couleur[i]);
        i++;
    }

    printf("\nCouleurs sans le premier caractère :\n");
    i = 0;
    while (couleur[i] != NULL) {
        printf("%s\n", couleur[i] + 1); // Décale d'un caractère
        i++;
    }

    printf("\nCouleurs en majuscule :\n");


    char **p = couleur; // Pointeur sur le tableau de chaînes

    while (*p != NULL) { // Tant qu'on n'atteint pas le NULL final
        char *c = *p; // Pointeur sur la chaîne actuelle

        while (*c != '\0') { // Tant qu'on n'atteint pas la fin de la chaîne
            char ch = *c;
            if (ch >= 'a' && ch <= 'z') { // Convertir en majuscule
                ch = ch - ('a' - 'A');
            }
            printf("%c", ch);
            c++; // Avancer dans la chaîne
        }

        printf("\n");
        p++; // Passer à la chaîne suivante
    }

    printf("\nCouleurs sans utiliser %%s :\n");
    char **z = couleur; // Pointeur sur le tableau de chaînes

    while (*z != NULL) { // Tant qu'on n'atteint pas NULL
        char *c = *z; // Pointeur sur la chaîne actuelle

        while (*c != '\0') { // Parcourt chaque caractère
            printf("%c", *c); // Affiche chaque caractère avec printf
            c++; // Avancer dans la chaîne
        }

        printf("\n"); // Nouvelle ligne après chaque couleur
        z++; // Passer à la chaîne suivante
    }

    return 0;
}
