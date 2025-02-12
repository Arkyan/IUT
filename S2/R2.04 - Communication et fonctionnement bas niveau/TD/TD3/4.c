#include <stdio.h>

char donner_majuscule(char c) {
    if (c >= 'a' && c <= 'z') {
        return c - 32;
    }
    return c;
}

void mettre_en_majuscule(char *str) {
    char *p = str;
    while (*p != '\0') {
        *p = donner_majuscule(*p);
        p++;
    }
}

int donner_longueur(char *str) {
    char *p = str;
    char *q = str;
    while (*q != '\0') {
        q++;
    }
    return q - p;
}

void inverser(char *str) {
    char *p = str;
    char *q = str + donner_longueur(str) - 1;
    while (p < q) {
        char temp = *p;
        *p = *q;
        *q = temp;
        p++;
        q--;
    }
}

void saisir(char *str) {
    printf("Entrez une chaine : ");
    fgets(str, 81, stdin);

    // Supprimer le '\n' ajouté par fgets
    int len = donner_longueur(str);
    if (len > 0 && str[len - 1] == '\n') {
        str[len - 1] = '\0';
    }
}

void afficher(char *str) {
    printf("Chaine: %s\n", str);
}

int sont_égales(char *str1, char *str2) {
    while (*str1 != '\0' && *str2 != '\0') {
        if (*str1 != *str2) {
            return 0;
        }
        str1++;
        str2++;
    }
    return *str1 == *str2;
}

int main(void) {
    char str1[81], str2[81];
    char *p1 = str1, *p2 = str2;

    // Saisie des chaînes
    saisir(p1);
    saisir(p2);

    // Calcul de la longueur de la première chaîne et affichage
    int longueur1 = donner_longueur(p1);
    printf("Longueur de la chaine 1: %d\n", longueur1);

    // Mise en majuscules et affichage des chaînes
    mettre_en_majuscule(p1);
    afficher(p1);
    mettre_en_majuscule(p2);
    afficher(p2);

    // Comparaison des chaînes
    if (sont_égales(p1, p2)) {
        printf("Les chaines sont egales\n");
    } else {
        printf("Les chaines ne sont pas egales\n");
    }

    // Inversion et affichage de la deuxième chaîne
    inverser(p2);
    afficher(p2);

    return 0;
}


