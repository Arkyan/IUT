##########################################################################
# Ce TP étant la suite du précédent il faut que vous rechargiez votre ####
# script du TP précédent pour avoir toutes les fonctions déjà         ####
# implémentées.                                                       ####
##########################################################################
creationMatrice <- function(valeurs, nbLignes, nbColonnes){
  if(length(valeurs)==(nbLignes*nbColonnes)){
    return(matrix(data=valeurs, nrow = nbLignes, ncol = nbColonnes, byrow = TRUE))
  }else{
    print("Le nombre de valeurs ne correspond pas aux dimensions de la matrice. ")
    print("Veuillez vérifier les informations saisies." )
    return(creationMatriceVide(nbLignes,nbColonnes))    
  }
}

##########################################################################
## Installation de package et chargement du package, si nécessaire  ######
##########################################################################
if (!require("matlib")) {
  install.packages("matlib")
}
library(matlib)
if (!require("MASS")) {
  install.packages("MASS")  
}
library(MASS)

##########################################################################
#  Création d'une fonction d'arrondi pour les calculs  en fin de TP ######
##########################################################################
mettreValeurMatriceAZero <- function(matriceA, precision = 1e-10) {
  matriceA[abs(matriceA) < precision] <- 0
  return(matriceA)
}

##########################################################################
############################### Exercice 1  ##############################
##########################################################################


#' Echanger deux lignes d'une matrice 
#'
#' @param matriceA 
#' @param ligne1 
#' @param ligne2 
#'
#' @return matriceA avec les lignes, ligne1 et ligne2, échangées
#' @export 
#'
#' @examples
echangeDeuxLignesDUneMatrice <- function (matriceA, ligne1, ligne2){
  temp <- matriceA[ligne1, ]
  matriceA[ligne1, ] <- matriceA[ligne2, ]
  matriceA[ligne2, ] <- temp
  return(matriceA)

}

matriceA <- creationMatrice(c(6,-1,1,0,-3,1,1,-2,1),nbLignes = 3, nbColonnes = 3)
matriceA
matriceB <- echangeDeuxLignesDUneMatrice(matriceA,1, 3)
matriceB
all.equal(matriceB, as.matrix(rowswap(matriceA,1,3)))

#' Mutliplication d'un ligne d'une matrice par un scalaire 
#'
#' @param matriceA 
#' @param ligne 
#' @param scalaire 
#'
#' @return matriceA avec la ligne ligne qui est multiplié par le scalaire scalaire. 
#' @export
#'
#' @examples
multiplierUneLigneDUneMatriceParUnScalaire <- function(matriceA, ligne, scalaire){
  matriceA[ligne,] <- matriceA[ligne,]*scalaire
  return(matriceA)
}

matriceB <- multiplierUneLigneDUneMatriceParUnScalaire(matriceA, 1,-3)
matriceB
all.equal(matriceB, as.matrix(rowmult(matriceA,1,-3)))


#' Ajout d'une ligne à une autre avec possibilité d'un coefficient multiplicateur
#'
#' @param matriceA 
#' @param ligneAAjouter 
#' @param ligneConcerne 
#' @param scalaire 
#'
#' @return la matriceA avec la ligneConcerne qui est égale à ligneConcerne +ligneAAjouter*scalaire
#' @export
#'
#' @examples
ajoutDUneLigneAUneAutre <- function(matriceA, ligneAAjouter, ligneConcerne, scalaire=1){
  matriceA[ligneConcerne,] <- matriceA[ligneConcerne,] + matriceA[ligneAAjouter,]*scalaire
  return(matriceA)
}

matriceB <- ajoutDUneLigneAUneAutre(matriceA, 3, 1, -6)
matriceB
all.equal(matriceB, as.matrix(rowadd(matriceA,3,1,-6)))

matriceB <- ajoutDUneLigneAUneAutre(matriceA, 1, 3, -1/6)
#as.matrix(fractions(matriceB))
fractions(matriceB)
all.equal(matriceB, as.matrix(rowadd(matriceA,1,3,-1/6)))

##########################################################################
############################### Exercice 2  ##############################
#Matrice a echelonnee
##########################################################################
############################### Matrice A  ###############################
#A=
#[1,2] 
#[5,4]
#[3,6]

#[1,2]
#[0,-6]
#[0,0]

############################### Matrice B  ###############################
#B= 
#[1,5,8]
#[5,25,40]
#[2,7,9]

#[1,5,8]
#[0,-3,1]
#[0,0,0]

############################### Matrice C  ###############################
#C=
#[1,2,4,6,9,11]
#[3,6,14,23,34,42]
#[-5,-10,-24,-40,-59,-70]

#[1,2,4,6,9,11]
#[0,0,2,5,7,9]
#[0,0,0,0,0,3]

############################### Matrice D  ###############################
#D= 
#[0,0,0,9]
#[0,4,7,11]
#[0,6,10.5,16.5]
#[0,12,21,15]

#[0,4,7,11]
#[0,0,0,9]
#[0,0,0,0]
#[0,0,0,0]

############################### Matrice E  ###############################
#E= 
#[2,1]
#[1,3]

#[2,1]
#[0,5]

############################### Matrice F  ###############################
#F=
#[1,2,-2,4]
#[0,1,3,-4]
#[0,0,1,-2]
#[1,1,-1,2]

#[1,2,-2,4]
#[0,1,3,-4]
#[0,0,1,-2]
#[0,0,0,0]
##########################################################################
############################### Exercice 3  ##############################
##########################################################################


#' Echelonne une matrice
#'
#' @param matriceA 
#'
#' @return matriceA mais échelonnée
#' @export
#'
#' @examples

echelonneUneMatrice <- function(matriceA) {
  nbLignes <- nrow(matriceA)
  nbColonnes <- ncol(matriceA)
  maxIndice <- min(nbLignes, nbColonnes) # Limite pour i
  
  for (i in 1:maxIndice) {
    if (i > nbLignes || i > nbColonnes) break  # Vérification explicite des limites
    
    if (matriceA[i, i] == 0) {
      for (j in (i+1):nbLignes) {
        if (j > nbLignes) break  # Protection dans la sous-boucle
        if (matriceA[j, i] != 0) {
          matriceA <- echangeDeuxLignesDUneMatrice(matriceA, i, j)
          break
        }
      }
    }
    if (matriceA[i, i] != 0) {
      matriceA <- multiplierUneLigneDUneMatriceParUnScalaire(matriceA, i, 1 / matriceA[i, i])
      for (j in (i+1):nbLignes) {
        if (j > nbLignes) break  # Vérification explicite
        matriceA <- ajoutDUneLigneAUneAutre(matriceA, i, j, -matriceA[j, i])
      }
    }
  }
  return(mettreValeurMatriceAZero(matriceA))
}



matriceG <- creationMatrice(c(0,0,1,2),2,2)
matriceG
matriceGEchelonnee <- echelonneUneMatrice(matriceG)
matriceGEchelonnee
matriceH <- creationMatrice(c(0,1,1,2),2,2)
matriceH
matriceHEchelonnee <- echelonneUneMatrice(matriceH)
matriceHEchelonnee
matriceK <- creationMatrice(c(6,-1,1,0,-3,1,1,-2,1),nbLignes = 3, nbColonnes = 3)
matriceK
matriceKEchelonnee <- echelonneUneMatrice(matriceK)
fractions(matriceKEchelonnee)

############### vérification avec l'exercice précédent ###################

all.equal(matriceAEchelonnee <- echelonneUneMatrice(matriceA), as.matrix(matriceA1))
all.equal(matriceBEchelonnee <- echelonneUneMatrice(matriceB), as.matrix(matriceB2))
all.equal(matriceCEchelonnee <- echelonneUneMatrice(matriceC), as.matrix(matriceC3))
all.equal(matriceDEchelonnee <- echelonneUneMatrice(matriceD), as.matrix(matriceD4))
all.equal(matriceEEchelonnee <- echelonneUneMatrice(matriceE), as.matrix(matriceE1))
all.equal(matriceFEchelonnee <- echelonneUneMatrice(matriceF), as.matrix(matriceF3))

##########################################################################
############################### Exercice 4  ##############################
##########################################################################

# Voir les résultats à la fin de l'exercice 5 ####

##########################################################################
############################### Exercice 5  ##############################
##########################################################################

#' Echelonner et réduire une matrice
#'
#' @param matriceA 
#'
#' @return matriceA mais échelonnée et réduite
#' @export
#'
#' @examples

echelonneEtReduitUneMatrice <- function(matriceA){
  nbLignes <- nrow(matriceA)
  nbColonnes <- ncol(matriceA)
  for (i in 1:nbLignes){
    if (matriceA[i,i] == 0){
      for (j in (i+1):nbLignes){
        if (matriceA[j,i] != 0){
          matriceA <- echangeDeuxLignesDUneMatrice(matriceA,i,j)
          break
        }
      }
    }
    if (matriceA[i,i] != 0){
      matriceA <- multiplierUneLigneDUneMatriceParUnScalaire(matriceA,i,1/matriceA[i,i])
      for (j in (i+1):nbLignes){
        matriceA <- ajoutDUneLigneAUneAutre(matriceA,i,j,-matriceA[j,i])
      }
    }
  }
  for (i in nbLignes:2){
    for (j in 1:(i-1)){
      matriceA <- ajoutDUneLigneAUneAutre(matriceA,i,j,-matriceA[j,i])
    }
  }
  return(mettreValeurMatriceAZero(matriceA))
 
}

matriceG <- creationMatrice(c(0,0,1,2),2,2)
matriceG
matriceGReduite <- echelonneEtReduitUneMatrice(matriceG)
matriceGReduite
matriceH <- creationMatrice(c(0,1,1,2),2,2)
matriceH
matriceHReduite <- echelonneEtReduitUneMatrice(matriceH)
matriceHReduite
matriceK <- creationMatrice(c(6,-1,1,0,-3,1,1,-2,1),nbLignes = 3, nbColonnes = 3)
matriceK
matriceKReduite <- echelonneEtReduitUneMatrice(matriceK)
matriceKReduite

############### vérification avec l'exercice précédent ###################

(matriceAReduite <- echelonneEtReduitUneMatrice(matriceA)); echelon(matriceA)
(matriceBReduite <- echelonneEtReduitUneMatrice(matriceB)); echelon(matriceB)
(matriceCReduite <- echelonneEtReduitUneMatrice(matriceC)); echelon(matriceC)
(matriceDReduite <- echelonneEtReduitUneMatrice(matriceD)); echelon(matriceD)
(matriceEReduite <- echelonneEtReduitUneMatrice(matriceE)); echelon(matriceE)
(matriceFReduite <- echelonneEtReduitUneMatrice(matriceF)); echelon(matriceF)

##########################################################################
############################### Exercice 6  ##############################
##########################################################################

############################### Systeme R  ###############################


############################### Systeme S  ###############################



############################### Systeme T  ###############################



############################### Systeme U  ###############################



##########################################################################
############################### Exercice 7  ##############################
##########################################################################

#' résolution d'un système qu'équation linéaire par la méthode du pivot de Gauss
#'
#' @param matriceA 
#' @param matriceB 
#'
#' @return La matrice augmantée (MatriceA|matriceB) échelonnée et réduite
#' @export
#'
#' @examples
#' 
resolutionSystemeMethodePivotDeGauss <- function(matriceA, matriceB){
  matriceA <- cbind(matriceA,matriceB)
  nbLignes <- nrow(matriceA)
  nbColonnes <- ncol(matriceA)
  for (i in 1:nbLignes){
    if (matriceA[i,i] == 0){
      for (j in (i+1):nbLignes){
        if (matriceA[j,i] != 0){
          matriceA <- echangeDeuxLignesDUneMatrice(matriceA,i,j)
          break
        }
      }
    }
    if (matriceA[i,i] != 0){
      matriceA <- multiplierUneLigneDUneMatriceParUnScalaire(matriceA,i,1/matriceA[i,i])
      for (j in (i+1):nbLignes){
        matriceA <- ajoutDUneLigneAUneAutre(matriceA,i,j,-matriceA[j,i])
      }
    }
  }
  for (i in nbLignes:2){
    for (j in 1:(i-1)){
      matriceA <- ajoutDUneLigneAUneAutre(matriceA,i,j,-matriceA[j,i])
    }
  }
  return(mettreValeurMatriceAZero(matriceA)[,nbColonnes])
 
}

matriceA <- creationMatrice(1:9, nbColonnes = 3,nbLignes = 3)
matriceB <- creationMatrice(1:3, nbColonnes = 1,nbLignes = 3)
matriceC <- creationMatrice(1:4, nbColonnes = 1,nbLignes = 4)
matriceA
matriceB
matriceC
matriceSolutionDuSystemeAB <- resolutionSystemeMethodePivotDeGauss(matriceA, matriceB )
fractions(matriceSolutionDuSystemeAB)
fractions(gaussianElimination(matriceA,matriceB))
matriceSolutionDuSystemeAC <- resolutionSystemeMethodePivotDeGauss(matriceA, matriceC )
matriceSolutionDuSystemeAC

##########################################################################
############################### Exercice 8  ##############################
##########################################################################


##########################################################################
############################### Exercice 9  ##############################
##########################################################################

############################### Systeme A  ###############################

A = 2,3,1  | 4
    1,1,2  | 3
    7,3,-5 | 2
    
    2,3,1  | 4
    0,-1,3 | 1
    0,0,-12| -26
    
    2,3,1  | 4
    0,-1,3 | 1
    0,0,1  | 13/4
    
    2,3,0  | 1
    0,-1,0 | 1
    0,0,1  | 13/4
    
    2,0,0  | 1
    0,-1,0 | 1
    0,0,1  | 13/4
    
    1,0,0  | 1/2
    0,1,0  | -1
    0,0,1  | 13/4


############################### Systeme B  ###############################
    
B = 1,2,-2 | 0
    2,0,-1 | 0
    1,-2,0 | 0
    
    1,2,-2 | 0
    0,-4,3 | 0
    0,-4,1 | 0
    
    1,2,-2 | 0
    0,-4,3 | 0
    0,0,1  | 0
    
    1,0,0 | 0
    0,1,0 | 0
    0,0,1 | 0

############################### Systeme C  ###############################
    
C = 4,2,-1 | 0
    3,-1,1 | 3
    1,1,1  | 1
    1,-1,1 | -2
    
    4,2,-1 | 0
    0,-5,4 | 3
    0,1,1  | 1
    0,-3,2 | -2
    
    4,2,-1 | 0
    0,-5,4 | 3
    0,0,0  | 0
    0,0,0  | 0
    
    4,2,-1 | 0
    0,-5,4 | 3
    
    4,2,-1 | 0
    0,1,0  | 1
    
    4,0,-1 | 0
    0,1,0  | 1
    
    1,0,-1/4 | 0
    0,1,0  | 1


############################### Systeme D  ###############################
    
D = 1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    1,0,1,-2,3 | 0
    1,1,4,-6,5 | 0
    0,3,0,2,0  | 0
    
    1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    0,-4,3,-6,2 | 0
    0,-1,3,-6,4 | 0
    0,3,0,2,0  | 0
    
    1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    0,-4,3,-6,2 | 0
    0,0,9,-10,6 | 0
    0,0,9,-10,6 | 0
    
    1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    0,0,9,-10,6 | 0
    0,0,9,-10,6 | 0
    0,0,9,-10,6 | 0
    
    1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    0,0,9,-10,6 | 0
    
    
    1,2,-2,4,1 | 0
    0,2,3,-4,2 | 0
    0,0,1,-10/9,2/3 | 0
    
    1,2,-2,4,1 | 0
    0,2,0,-5,4 | 0
    0,0,1,-10/9,2/3 | 0
    
    1,0,-2,14/9,1/3 | 0
    0,1,0,-5/9,2/3 | 0
    
    



##########################################################################
############################### Exercice 10 ##############################
##########################################################################

A = 2,4,1
    -1,1,-1
    1,4,0
    
I3 = 1,0,0
     0,1,0
     0,0,1
     
#Pivot de Gauss sur A et I3 pour avoir (I3|B)
    
    2,4,1 | 1,0,0
    -1,1,-1 | 0,1,0
    1,4,0 | 0,0,1
    
    2,4,1 | 1,0,0
    0,5,0 | 1,2,0
    0,0,-1 | -1,0,1
    
    2,4,1 | 1,0,0
    0,5,0 | 1,2,0
    0,0,1 | 1,0,-1
    
    2,4,0 | 1,0,-1
    0,5,0 | 1,2,0
    0,0,1 | 1,0,-1
    
    2,0,0 | 1,-2,-1
    0,5,0 | 1,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1
    
    1,0,0 | 1/2,-1,-1/2
    0,1,0 | 1/5,2,0
    0,0,1 | 1,0,-1

B = 1/2,-1,-1/2
    1/5,2,0
    1,0,-1
    
A x B = 1/2 - 1 + 1/2 = 0
        1/5 - 2 + 0 = 0
        1 - 0 - 1 = 0

#C'est égal à 0 

##########################################################################
############################### Exercice 11 ##############################
##########################################################################
        
A = 3,0,0
    1,2,-1
    1,-1,2
    
#Inverse de A


    
#A^2 - 4A + 3I



##########################################################################
############################### Exercice 12 ##############################
##########################################################################

############################### Matrice A  ###############################



############################### Matrice B  ###############################



############################### Matrice C  ###############################



##########################################################################
############################### Exercice 13 ##############################
##########################################################################



############################### Question 1 a #############################



############################### Question 1 b #############################



############################### Question 2 a #############################
# Facile à faire il faut simplement développer et utiliser le fait que k^^2 = -I
############################### Question 2 b #############################
#On montre facilement par le calcul de que l'inverse de M  est (2aI-M)/(a^2+b^2) 
############################### Question 2 c #############################

