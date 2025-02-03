//
// Created by didry on 03/02/2025.
//
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
  void *p;
  int i;

  for (i=0;i<500000;i++)
    {
    p=malloc(0x80000000);
    printf("p= %p\n", p);
    free(p);
    if (p==0)
      {
      printf("Malloc renvoie 0 !!Erreur ! \n");
      exit(1);
      }
    }
      return 0;
  }