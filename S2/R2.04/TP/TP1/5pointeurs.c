//
// Created by didry on 04/02/2025.
//
#include <stdio.h>

int main(void) {
    char str[81];
    char *p;
    int i = 0;

    printf("Saisissez une chaine de caractères : ");
    scanf("%s", str);

    p = str;

    while (*p != '\0') {
        i++;
        p++;
    }

    printf("La longueur de la chaine de caractères est %d\n", i);

    return 0;
}
