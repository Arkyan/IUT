//
// Created by didry on 28/01/2025.
//
#include<stdio.h>
void permut(int a, int b) {
    int c;
    c=a;
    a=b;
    b=c;
}

int main(void)
{
  int n1=5;
    int n2=8;

    printf("Avant permutation : n1=%d, n2=%d\n", n1, n2);
    permut(n1, n2);

    printf("Après permutation : n1=%d, n2=%d\n", n1, n2);
    return 0;
}