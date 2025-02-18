//
// Created by didry on 18/02/2025.
//

#include <stdio.h>

void main(void) {
  char *p[6] = {"ABC", "DEFGH", "IJKLM", "NOPQRS", "TUV", NULL};

  int i;

  // Affichage dans l'ordre
  printf("Liste normale :\n");
  for (i = 0; p[i] != NULL; i++) {
    printf("%s\n", p[i]);
  }

  // Affichage à l'envers
  printf("\nListe inversée :\n");
  for (i = i - 1; i >= 0; i--) { // On repart du dernier élément valide
    printf("%s\n", p[i]);
  }
}
