//
// Created by didry on 11/02/2025.
//

#include <stdio.h>

// Fonction de copie de chaîne
char *copiechaine(char *dest, char *src) {
    char *p = dest; // Pointeur pour garder l'adresse de départ de dest
    while (*src != '\0') {
        *dest = *src;
        dest++;
        src++;
    }
    *dest = '\0'; // Ajout du caractère de fin de chaîne
    return p; // Retourne l'adresse initiale de dest
}

int main() {
    char str1[100], str2[100];

    printf("Entrez une chaine : ");
    scanf("%s", str1); // %99s pour éviter le dépassement de mémoire
    // Appel de la fonction copiechaine
    copiechaine(str2, str1);

    printf("Chaine copiée: %s", str2);
    return 0;
}
