//
// Created by didry on 11/02/2025.
//
//Saisie chaine puis transfo avec une fonction de minuscule à majuscule avec pointeurs

#include <stdio.h>

void majuscule(char *str) {
    char *p = str;
    while (*p != '\0') {
        if (*p >= 'a' && *p <= 'z') {
            *p = *p - 32;
        }
        p++;
    }
}

int main() {
    char str[100];

    printf("Entrez une chaine : ");
    gets(str);

    majuscule(str);

    printf("Chaine en majuscule: %s\n", str);
    return 0;
}