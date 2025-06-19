//
// Created by didry on 11/02/2025.
//
//Saisie chaine transformation en majuscule en utiilisant pointeurs

#include <stdio.h>

int main() {
    char str[100];
    char *p;

    printf("Entrez une chaine : ");
    scanf("%s", str); //

    p = str;

    while (*p != '\0') {
        if (*p >= 'a' && *p <= 'z') {
            *p = *p - 32;
        }
        p++;
    }

    printf("Chaine en majuscule: %s\n", str);
    return 0;
}