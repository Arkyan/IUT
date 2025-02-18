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
    i = 0;
    while (couleur[i] != NULL) {
        int j = 0;
        while (couleur[i][j] != '\0') {
            char c = couleur[i][j];
            if (c >= 'a' && c <= 'z') { // Convertir en majuscule manuellement
                c = c - ('a' - 'A');
            }
            printf("%c", c);
            j++;
        }
        printf("\n");
        i++;
    }

    printf("\nCouleurs sans utiliser %%s :\n");
    i = 0;
    while (couleur[i] != NULL) {
        int j = 0;
        while (couleur[i][j] != '\0') {
            putchar(couleur[i][j]); // Affiche caractère par caractère
        }
        putchar('\n');
        i++;
    }

    return 0;
}
