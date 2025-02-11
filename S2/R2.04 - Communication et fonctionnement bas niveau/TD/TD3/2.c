//
// Created by didry on 11/02/2025.
//
#include <stdio.h>

int main(void) {
    char str1[100], str2[100], str3[100];
    printf("Entrez une chaine : ");
    gets(str1);
    printf("Entrez une 2e chaine : ");
    gets(str2);

    //Copier str1 dans str3
    char *p1 = str1, *p3 = str3;
    while (*p1 != '\0') {
        *p3 = *p1;
        p1++;
        p3++;
    }

    //Afficher str3 %s
    printf("Chaine copiee: %s\n", str3);

    //concaténer str2 à str3
    char *p2 = str2;
    while (*p2 != '\0') {
        *p3 = *p2;
        p2++;
        p3++;
    }

    //Afficher str3 %s
    printf("Chaine concatenee: %s\n", str3);
}