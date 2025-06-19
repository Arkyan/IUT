//
// Created by didry on 28/01/2025.
//
#include<stdio.h>
#include<stdlib.h>

int nbelnts=10;

void mafct()
{
  static int c=0;
  int a=0;
  a++;
  c++;
    printf("a=%d, c=%d\n", a, c);
}

int main(void)
{
  int *tab;
  int i;

  printf("Adresse de i=%d\n", &i);
  for (i=0;i<5;i++)
    mafct();

  printf("Adresse de nbelnts=%x\n", &nbelnts);
  tab=malloc(nbelnts*sizeof(int));
  *tab=5;
  *(tab+1)=8;

  printf("1er elent tab=%d 2eme elent tab=%d\n", *tab, *(tab+1));
  printf("adresse du 1er elent tab=%x adresse du 2eme elent tab=%x\n", tab, tab+1);
  free(tab);
  return 0;
}