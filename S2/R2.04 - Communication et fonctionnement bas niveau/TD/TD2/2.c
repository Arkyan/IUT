//
// Created by didry on 03/02/2025.
//
#include <stdio.h>

int main(void) {
  int tab[10];
  int n=5;

  for (int i=0; i<10; i++)
    tab[i]=n++;

  printf("tab[9]= %d\n", tab[9]);
  }

