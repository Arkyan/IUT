##########################################################################
## Installation de package et chargement du package, si nécessaire #######
##########################################################################
if (!require("MASS")) {
  install.packages("MASS")  
}
library(MASS)
if (!require("igraph")) {
  install.packages("igraph")  
}
library(igraph)
##########################################################################
############################### Exercice 1  ##############################
##########################################################################

#' Création d'une matrice vide de dimensions données.
#'
#' @param nbLignes 
#' @param nbColonnes 
#'
#' @return une matrice vide de dimensions données. 
#' @export
#'
#' @examples
#' creationMatriceVide(nbLignes=3,nbColonnes=3)
creationMatriceVide <- function( nbLignes, nbColonnes){
    # Création d'une matrice vide
    matriceVide <- matrix(nrow = nbLignes, ncol = nbColonnes)
    return(matriceVide)
  }

#' Création d'une matrice 
#'
#' @param valeurs 
#' @param nbLignes 
#' @param nbColonnes 
#'
#' @return Une matrice aux dimensions demandées mais sans valeurs si le vecteur 
#' valeurs n'a pas assez de valeurs. 
#' @export
#'
#' @examples
creationMatrice <- function(valeurs, nbLignes, nbColonnes){
    if (length(valeurs) < nbLignes*nbColonnes) {
      print("Le nombre de valeurs ne correspond pas aux dimensions de la matrice")
      return(creationMatriceVide(nbLignes, nbColonnes))
    } else {
      print("Création de la matrice")
      return(matrix(valeurs, nrow = nbLignes, ncol = nbColonnes, byrow = TRUE))
    }
  }

premiereMatrice <- creationMatrice(1:8, nbLignes= 3 , nbColonnes = 3)
premiereMatrice
secondeMatrice <- creationMatrice(1:9, nbLignes= 3 , nbColonnes = 3)
secondeMatrice

##########################################################################
############################### Exercice 2  ##############################
##########################################################################

#' Additionne deux matrices
#'
#' @param matriceA 
#' @param matriceB 
#'
#' @return matriceA + matriceB
#' @export
#'
#' @examples
additionDeDeuxMatrices <- function(matriceA, matriceB){
  if (all(dim(matriceA) != dim(matriceB))) {
    print("Les matrices n'ont pas les mêmes dimensions")
    return(NULL)
  } else {
    print("Addition des deux matrices")
    for (i in seq_len(nrow(matriceA))) {
      for (j in seq_len(ncol(matriceA))) {
        matriceA[i,j] <- matriceA[i,j] + matriceB[i,j]
      }
    }
    return(matriceA)
  }
}

troisiemeMatrice <-creationMatrice(rep(4:6, 3), nbColonnes = 3, nbLignes = 3)
troisiemeMatrice
quatriemeMatrice <- creationMatrice(rep(1:3,2),nbLignes = 2, nbColonnes = 3)
quatriemeMatrice
cinquiemeMatrice <- additionDeDeuxMatrices(secondeMatrice,troisiemeMatrice)
cinquiemeMatrice
all.equal(cinquiemeMatrice, secondeMatrice+troisiemeMatrice)
sixiemeMatrice <- additionDeDeuxMatrices(secondeMatrice, quatriemeMatrice)
sixiemeMatrice
#all.equal(sixiemeMatrice, secondeMatrice+quatriemeMatrice)
#secondeMatrice+quatriemeMatrice

##########################################################################
############################### Exercice 3  ##############################
##########################################################################

############################### Question 1 ############################### 
matriceA <- creationMatrice(c(1,-0.5,(1/3),0,0.5,0), 2,3)
matriceA

matriceB <- creationMatrice(c(1,0.5,1,9,5,sqrt(2)),2,3)
matriceB

matriceAdditionAB <- additionDeDeuxMatrices(matriceA, matriceB)
matriceAdditionAB

############################### Question 2 ############################### 
matriceC <- creationMatrice(c(0,-1,0,6,0,0,0,0,2), 3,3)
matriceC

matriceD <- creationMatrice(c(1,-1,0,6,1,1,1,1,2), 3,3)
matriceD

matriceAdditionCD <- additionDeDeuxMatrices(matriceC, matriceD)
matriceAdditionCD

##########################################################################
############################### Exercice 4  ##############################
##########################################################################

#' Permet de faire la conversion d'une matrice quelconque en matrice boolénne
#' en prenant le postulat que si une valeur est différente de 0, c'est qu'en booléen 
#' cette valeur vaut 1. 
#'
#' @param uneMatrice 
#'
#' @return une matrice booleenne 
#' @export
#'
#' @examples
#' matriceBoolenneA <- convertionMatriceEnMatriceBoolenne(matriceA)
#' 
convertionMatriceEnMatriceBoolenne <- function(uneMatrice){
  return(matrix(as.integer(uneMatrice != 0), nrow = nrow(uneMatrice), ncol = ncol(uneMatrice)))
}


additionDeDeuxMatricesBoolennes <- function(matriceA, matriceB){
  for (i in seq_len(nrow(matriceA))) {
    for (j in seq_len(ncol(matriceA))) {
      matriceA[i,j] <- matriceA[i,j] + matriceB[i,j]
      if (matriceA[i, j] > 1) {
        matriceA[i, j] <- 1
      }
    }
  }
  return(matriceA)
}

matriceBoolenneA <- convertionMatriceEnMatriceBoolenne(matriceA)
matriceBoolenneB <- convertionMatriceEnMatriceBoolenne(matriceC[2:3,])
matriceBoolenneA
matriceBoolenneB
matriceBoolenneAPlusB <- additionDeDeuxMatricesBoolennes(matriceBoolenneA,matriceBoolenneB)
matriceBoolenneAPlusB

##########################################################################
############################### Exercice 5  ##############################
##########################################################################

transposeDUneMatrice <- function(matrice) {
  n <- nrow(matrice)
  m <- ncol(matrice)
  
  transposed <- matrix(0, nrow = m, ncol = n)
  
  for (i in 1:n) {
    for (j in 1:m) {
      transposed[j, i] <- matrice[i, j]
    }
  }
  
  return(transposed)
}


transposeeMatriceA <- transposeDUneMatrice(matriceA)
transposeeMatriceA
all.equal(transposeeMatriceA, t(matriceA))

##########################################################################
############################### Exercice 6  ##############################
##########################################################################
Matrice1Exo6 <- creationMatrice(c(1,-1, 2, 5, -1, 0.5, 2, 0.4, 0, 3, 2, 0.1), 3, 4)
TranspoMatrice1 <- transposeDUneMatrice(Matrice1Exo6)
Matrice1Exo6
TranspoMatrice1

Matrice2Exo6 <- creationMatrice(c(1, -1, 2, 2, 0, 32, 3, -9, 0), 3, 3)
TranspoMatrice2 <- transposeDUneMatrice(Matrice2Exo6)
Matrice2Exo6
TranspoMatrice2


##########################################################################
############################### Exercice 7  ##############################
##########################################################################

#' Produit de deux matrices
#'
#' @param matriceA 
#' @param matriceB 
#'
#' @return matriceA * matriceB
#' @export
#'
#' @examples
produitDeDeuxMatrices <- function(matriceA, matriceB){
  
  
}

matriceA <- creationMatrice(c(1,-0.5,fractions(1/3),0,0.5,0), 2,3)
matriceB <- creationMatrice(c(1,0.5,1,9,5,sqrt(2)),2,3)
matriceAB <- produitDeDeuxMatrices(matriceA, matriceB)
matriceAB
matriceC <- creationMatrice(c(0,-1,0,6,0,0,0,0,2), 3,3)
matriceD <- creationMatrice(c(1,-1,0,6,1,1,1,1,2), 3,3)
matriceCD <- produitDeDeuxMatrices(matriceC, matriceD)
matriceCD
all.equal(matriceCD, matriceC %*% matriceD)


##########################################################################
############################### Exercice 8  ##############################
##########################################################################


############################### Question 1 ############################### 


############################### Question 2 ############################### 


##########################################################################
############################### Exercice 9  ##############################
##########################################################################
produitDeDeuxMatricesBooleennes <- function(matriceBoolenneA, matriceBoolenneB){
}


matriceBoolenneA <- convertionMatriceEnMatriceBoolenne(matriceA)
matriceBoolenneB <- transposeDUneMatriceV2(convertionMatriceEnMatriceBoolenne(matriceC[2:3,]))
matriceBoolenneA
matriceBoolenneB
matriceBoolenneAB <- produitDeDeuxMatricesBooleennes(matriceBoolenneA,matriceBoolenneB)
matriceBoolenneAB

##########################################################################
############################### Exercice 10 ##############################
##########################################################################


############################### Question 1 ############################### 

############################ Questions 2 et 3 ############################ 

############################## Réflexivité ###############################


############################## Symetrie ##################################

############################## Antisymetrie ##############################


############################## Transitivité ##############################


##########################################################################
############################### Exercice 11 ##############################
##########################################################################

matriceR <- creationMatrice(c(1,1,0,1,0,1,1,1,0,0,0,1,1,1,1,1,0,1,1,1,0,0,1,1,1), nbLignes = 5, nbColonnes = 5)
matriceR
matriceS <- creationMatrice(c(1,1,0,0,1,1,0,0,1,1,1,0,0,0,0,1), nbLignes = 4, nbColonnes = 4)
matriceS
matriceT <- creationMatrice(c(1,1,0,0,1,0,1,0,0,0,0,1,1,1,0,0,1,0,1,0,0,0,0,0,1), nbLignes = 5, nbColonnes = 5)
matriceT

############################### relation R ###############################


############################### relation S ###############################



############################### relation T ###############################


##########################################################################
############################### Exercice 12 ##############################
##########################################################################

##########################################################################
############################### Exercice 13 ##############################
##########################################################################


















