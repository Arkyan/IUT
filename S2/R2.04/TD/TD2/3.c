//
// Created by didry on 03/02/2025.
//
#include <stdio.h>

int fct(int n) {
  int res=0;
  if (n==0)
    return 0;
  else
  {
    res=1+fct(n-1);
    return res;
  }
}

int main(void) {
  int resu;
  resu=fct(100000);
  printf("resultat= %d\n", resu);
}
