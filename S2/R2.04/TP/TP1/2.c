//
// Created by didry on 04/02/2025.
//

#include <stdio.h>

int main(void) {
    int n1;
    int n2;

    printf("Saisissez un nombre entier : ");
    scanf("%d", &n1);

    printf("Saisissez un autre nombre entier : ");
    scanf("%d", &n2);

    if (n1 > n2) {
        printf("Le nombre %d est plus grand que le nombre %d\n", n1, n2);
    } else if (n1 < n2) {
        printf("Le nombre %d est plus petit que le nombre %d\n", n1, n2);
    } else {
        printf("Les deux nombres sont égaux\n");
    }
    return 0;
}