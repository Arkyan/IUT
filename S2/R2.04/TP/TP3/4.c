//
// Created by didry on 18/02/2025.
//

#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Nombre d'arguments: %d\n", argc - 1);
    printf("Arguments inversés:\n");
    for (int i = argc - 1; i > 0; i--) {
        printf("%s\n", argv[i]);
    }
    return 0;
}