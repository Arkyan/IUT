//
// Created by didry on 04/02/2025.
//
#include <stdio.h>
int main(void) {
    int n;
    int predn;
    int succn;

    printf("Saisissez un nombre entier : ");
    scanf("%d", &n);

    predn = n - 1;
    succn = n + 1;

    printf("Le nombre écrit est %d\n", n);
    printf("Son prédécesseur sous forme décimal est %d, sous forme hexadécimale est %x et sous forme octale est %o\n", predn, predn, predn);
    printf("Son successeur sous forme décimal est %d, sous forme hexadécimale est %x et sous forme octale est %o\n", succn, succn, succn);

    return 0;
}