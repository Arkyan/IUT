//
// Created by didry on 18/02/2025.
//

// programme recevant 2 arguments sur la ligne de commande et affiche s'il sont identiques ou non

#include <stdio.h>

// Fonction pour comparer deux chaînes de caractères
int str_compare(char *s1, char *s2) {
    while (*s1 && *s2) {
        if (*s1 != *s2) {
            return 0; // Différent
        }
        s1++;
        s2++;
    }
    return (*s1 == *s2); // Vrai si les deux se terminent en même temps
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <arg1> <arg2>\n", argv[0]);
        return 1;
    }

    if (str_compare(argv[1], argv[2])) {
        printf("Les deux arguments sont identiques\n");
    } else {
        printf("Les deux arguments ne sont pas identiques\n");
    }

    return 0;
}
