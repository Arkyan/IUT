//
// Created by didry on 18/02/2025.
//

#include <stdio.h>

void main(void) {
  char *jour[8] = {"lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche", NULL};

  //Afficher les jours de la semaine avec %s
  printf("Jours de la semaine :\n");
  int i = 0;
  while (jour[i] != NULL) {
    printf("%s\n", jour[i]);
    i++;
  }

  //Afficher les jours de la semaine par caractère avec %c
  printf("\nJours de la semaine par caractère :\n");
  i = 0;
  while (jour[i] != NULL) {
    int j = 0;
    while (jour[i][j] != '\0') {
      printf("%c", jour[i][j]);
      j++;
    }
    printf("\n");
    i++;
  }

  //Afficher les jours de la semaine du dimanche au lundi avec %s
  printf("\nJours de la semaine du dimanche au lundi :\n");
  i = 6;
  while (i >= 0) {
    printf("%s\n", jour[i]);
    i--;
  }

  //Permuter les jours de la semaine 1er avec dernier, 2e avec avant-dernier, etc. avec uniquement les pointeurs
  printf("\nPermutation des jours de la semaine :\n");
  i = 0;
  int j = 6;
  while (i < j) {
    char *temp = jour[i];
    jour[i] = jour[j];
    jour[j] = temp;
    i++;
    j--;
  }

  i = 0;
  while (jour[i] != NULL) {
    printf("%s\n", jour[i]);
    i++;
  }

  //Afficher le nouveau tableau en majuscule sans modif les chaines en mémoire
  printf("\nJours de la semaine en majuscule :\n");
  i = 0;
  while (jour[i] != NULL) {
    int j = 0;
    while (jour[i][j] != '\0') {
      char c = jour[i][j];
      if (c >= 'a' && c <= 'z') {
        c = c - ('a' - 'A');
      }
      printf("%c", c);
      j++;
    }
    printf("\n");
    i++;
  }
}