//
// Created by didry on 28/01/2025.
//
#include<stdio.h>
int main(void) {
    int *p;
    int n;

    n=10;
    p=&n;
    printf("L'entier n vaut %d, il est stocké à l'adresse %x\n", *p, p);
    printf("L'adresse de p est %x\n", &p);
    return 0;
}