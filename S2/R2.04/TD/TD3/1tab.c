//
// Created by didry on 11/02/2025.
//

//permettant de copier une chaine str1 dans une chaine str2 en utilisant les notations de tableau avec scanf
#include <stdio.h>

int main() {
    char str1[100], str2[100];
    int i = 0;

    printf("Entrez une chaine : ");
    scanf("%s", str1); // %99s pour éviter le dépassement de mémoire

    while (str1[i] != '\0') {
        str2[i] = str1[i];
        i++;
    }
    str2[i] = '\0';

    printf("Chaine copiée: %s\n", str2);
    return 0;
}
