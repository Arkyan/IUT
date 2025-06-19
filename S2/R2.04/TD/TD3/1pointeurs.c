//
// Created by didry on 11/02/2025.
//

//permettant de copier une chaine str1 dans une chaine str2 en utilisant les notations de pointeurs
#include <stdio.h>


#include <stdio.h>

int main() {
    char str1[100], str2[100];
    char *p1, *p2;

    printf("Entrez une chaine : ");
    scanf("%s", str1); //

    p1 = str1;
    p2 = str2;

    while (*p1 != '\0') {
        *p2 = *p1;
        p1++;
        p2++;
    }
    *p2 = '\0';

    printf("Chaine copiée: %s\n", str2);
    return 0;
}

