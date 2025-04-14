##########################################################################
## Installation de package et chargement du package, si nécessaire #######
##########################################################################
if (!require("igraph")) {
  install.packages("igraph")  
}
library(igraph)
if (!require("igraphdata")) {
  install.packages("igraphdata")
}
library(igraphdata)

##########################################################################
############################### Pré requis  ##############################
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
  return(matrix(nrow= nbLignes,ncol = nbColonnes ))
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
  if(length(valeurs)==(nbLignes*nbColonnes)){
    return(matrix(data=valeurs, nrow = nbLignes, ncol = nbColonnes, byrow = TRUE))
  }else{
    print("Le nombre de valeurs ne correspond pas aux dimensions de la matrice. ")
    print("Veuillez vérifier les informations saisies." )
    return(creationMatriceVide(nbLignes,nbColonnes))    
  }
}

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
  if (all(dim(matriceA)==dim(matriceB))) {
    matriceResultat <- creationMatriceVide(nrow(matriceA), ncol(matriceA))
    for (compteurLigne in seq_len(nrow(matriceA))) {
      for (compteurColonne in seq_len(ncol(matriceA))) {
        matriceResultat[compteurLigne,compteurColonne] <- matriceA[compteurLigne, compteurColonne]+matriceB[compteurLigne,compteurColonne]
      }      
    }
    return(matriceResultat)
  }else {
    print("Erreur les deux matrices n'ont pas les mêmes dimensions.")
    print("L'opération est donc impossible.")
    return()
  }
}



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
  if (ncol(matriceA)== nrow(matriceB)) {
    matriceResultat <- creationMatriceVide(nbLignes = nrow(matriceA), nbColonnes = ncol(matriceB))
    for (compteurLigne in seq_len(nrow(matriceA))) {
      for (compteurColonne in seq_len(ncol(matriceB))) {
        somme <-0
        for (compteur in seq_len(ncol(matriceA))) {
          somme  <- somme + matriceA[compteurLigne, compteur] * matriceB[compteur, compteurColonne]      
        }
        matriceResultat[compteurLigne, compteurColonne] <- somme
      }      
    }
    return(matriceResultat)
  }else{
    print("Erreur les matrices n'ont pas les bonnes dimensions")
    return()
  }
}

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

convertionMatriceEnMatriceBoolenne <- function( uneMatrice){
  return(ifelse(uneMatrice ==0 , 0 , 1))
  
}

additionDeDeuxMatricesBooleennes <- function(matriceA, matriceB){
  
  matriceResultat <- additionDeDeuxMatrices(matriceA = matriceA, matriceB = matriceB)
  return(convertionMatriceEnMatriceBoolenne(matriceResultat))
}

produitDeDeuxMatricesBooleennes <- function(matriceBoolenneA, matriceBoolenneB){
  matriceResultat <- produitDeDeuxMatrices(matriceBoolenneA, matriceBoolenneB)
  return(convertionMatriceEnMatriceBoolenne(matriceResultat))
}

###############################################################################################################
###############################################################################################################
################################################## TP3 ########################################################"'
###############################################################################################################
###############################################################################################################
graphtp3ex1 <- matrix(c(0,1,0,0,1,0,0,0,
                        0,0,1,0,0,1,0,0,
                        0,0,0,1,0,0,0,1,
                        0,0,0,0,0,0,0,0,
                        0,0,0,0,0,1,0,0,
                        1,0,1,0,0,0,1,0,
                        0,0,1,0,0,0,0,0,
                        0,0,0,1,0,0,1,0
), ncol = 8, byrow = TRUE)

GRAPHTP3EXO3 <- graph_from_adjacency_matrix(graphtp3ex1, mode = "directed")
plot(GRAPHTP3EXO3)

is_connected(GRAPHTP3EXO3, mode = "strong")
composantesGraphes <- components(GRAPHTP3EXO3, mode = "strong")

lkeojgoperjgpoidrjegpoidrhpioh <- contract(GRAPHTP3EXO3, composantesGraphes$membership, vertex.attr.comb = toString)
plot(lkeojgoperjgpoidrjegpoidrhpioh)

# TP3 EXERCICE 2
graphtp3ex2 <- matrix(c(0,0,1,0,0,1,0,
                        0,0,0,0,0,1,0,
                        0,0,0,0,0,0,1,
                        0,0,0,0,1,0,0,
                        0,1,0,0,0,0,0,
                        0,0,0,1,0,0,0,
                        1,1,0,0,0,0,0
), ncol = 7, byrow = TRUE)
GRAPHETP3EXO2 <- graph_from_adjacency_matrix(graphtp3ex2, mode = "directed")
plot(GRAPHETP3EXO2)

is_connected(GRAPHETP3EXO2, mode = "strong")
composantesGraphes2 <- components(GRAPHETP3EXO2, mode = "strong")

lkeojgoperjgpoidrjegpoidrhpioh2 <- contract(GRAPHETP3EXO2, composantesGraphes2$membership, vertex.attr.comb = toString)
plot(lkeojgoperjgpoidrjegpoidrhpioh2)


# TP3 EXERCICE 3
graphtp3ex3 <- matrix(c(0,1,0,0,0,1,0,0,0,0,0,
                        1,0,1,1,0,0,0,0,0,0,0,
                        0,0,0,1,0,0,0,0,0,0,0,
                        0,0,0,0,1,0,0,0,0,0,0,
                        0,0,0,1,0,0,0,0,0,0,1,
                        0,0,0,0,0,0,1,0,0,0,0,
                        0,0,0,0,0,0,0,1,0,0,0,
                        0,0,0,1,0,1,0,0,1,0,0,
                        0,0,0,1,1,0,0,1,0,0,1,
                        1,0,0,0,0,1,0,0,0,0,0,
                        0,0,0,0,0,0,0,0,0,0,0
), ncol = 11, byrow = TRUE)
GRAPHETP3EXO3 <- graph_from_adjacency_matrix(graphtp3ex3, mode = "directed")
plot(GRAPHETP3EXO3)

is_connected(GRAPHETP3EXO3, mode = "strong")
composantesGraphes3 <- components(GRAPHETP3EXO3, mode = "strong")

deiouffzoeutrfeodsue <- contract(GRAPHETP3EXO3, composantesGraphes3$membership, vertex.attr.comb = toString)
plot(deiouffzoeutrfeodsue)

# TP3 EXERCICE 4
graphtp3ex4 <- matrix(c(0,1,1,0,0,0,1,0,0,
                        0,0,0,1,0,0,0,0,0,
                        0,0,0,0,0,1,0,0,1,
                        0,0,0,0,0,0,1,0,0,
                        0,0,0,1,0,0,0,0,0,
                        0,0,1,0,0,0,1,0,1,
                        0,0,0,1,1,0,0,0,0,
                        0,0,0,0,0,0,1,1,1,
                        0,0,0,0,0,0,0,0,0
), ncol = 9, byrow = TRUE)
GRAPHETP3EXO4 <- graph_from_adjacency_matrix(graphtp3ex4, mode = "directed")
plot(GRAPHETP3EXO4)

is_connected(GRAPHETP3EXO4, mode = "strong")
composantesGraphes4 <- components(GRAPHETP3EXO4, mode = "strong")

sedrftgyhujiko <- contract(GRAPHETP3EXO4, composantesGraphes4$membership, vertex.attr.comb = toString)
plot(sedrftgyhujiko)

# TP3 EXERCICE 5
graphtp3ex5 <- matrix(c(0,1,0,0,0,0,0,0,
                        0,0,1,0,1,0,0,0,
                        0,0,0,0,0,0,1,0,
                        0,0,0,0,0,0,0,1,
                        1,0,0,0,0,0,0,0,
                        0,0,0,0,0,0,1,0,
                        0,0,0,0,0,0,0,0,
                        0,0,0,1,0,0,0,0
), ncol = 8, byrow = TRUE)
GRAPHETP3EXO5 <- graph_from_adjacency_matrix(graphtp3ex5, mode = "directed")
plot(GRAPHETP3EXO5)

is_connected(GRAPHETP3EXO5, mode = "strong")
composantesGraphes5 <- components(GRAPHETP3EXO5, mode = "strong")

sdftguiuhygfchuiytfgdghiouhgfcxfghi <- contract(GRAPHETP3EXO5, composantesGraphes5$membership, vertex.attr.comb = toString)
plot(sdftguiuhygfchuiytfgdghiouhgfcxfghi)

m2exo5 <- produitDeDeuxMatricesBooleennes(graphtp3ex5, graphtp3ex5)
additionexo5 <- additionDeDeuxMatricesBooleennes(graphtp3ex5, m2exo5)
additionexo5
m3exo5 <- produitDeDeuxMatricesBooleennes(m2exo5, graphtp3ex5)
additionexo5 <- additionDeDeuxMatricesBooleennes(additionexo5, m3exo5)
additionexo5
m4exo5 <- produitDeDeuxMatricesBooleennes(m3exo5, graphtp3ex5)
additionexo5 <- additionDeDeuxMatricesBooleennes(additionexo5, m4exo5)
additionexo5
m5exo5 <- produitDeDeuxMatricesBooleennes(m4exo5, graphtp3ex5)
additionexo5 <- additionDeDeuxMatricesBooleennes(additionexo5, m5exo5)
additionexo5

fermetureGraphiqueexo5 <- graph_from_adjacency_matrix(additionexo5, mode = "directed")
V(fermetureGraphiqueexo5)$name <- c("A", "B", "C", "D", "E", "F", "G", "H")
plot(fermetureGraphiqueexo5)

# TP3 EXERCICE 6
graphtp3ex6 <- matrix(c(0,1,0,0,0,1,
                        0,0,1,0,1,1,
                        0,0,0,0,0,0,
                        0,1,0,0,0,0,
                        0,0,0,0,0,0,
                        0,0,0,0,0,0
), ncol = 6, byrow = TRUE)
GRAPHETP3EXO6 <- graph_from_adjacency_matrix(graphtp3ex6, mode = "directed")
plot(GRAPHETP3EXO6)

is_connected(GRAPHETP3EXO6, mode = "strong")
composantesGraphes6 <- components(GRAPHETP3EXO6, mode = "strong")

yfhiusdujfijlerdhfjhdfgojujrihgjfzeojihtgkzohggtjrfjiorehgiterfhuofdguri <- contract(GRAPHETP3EXO6, composantesGraphes6$membership, vertex.attr.comb = toString)
plot(yfhiusdujfijlerdhfjhdfgojujrihgjfzeojihtgkzohggtjrfjiorehgiterfhuofdguri)

m2exo6 <- produitDeDeuxMatricesBooleennes(graphtp3ex6, graphtp3ex6)
additionexo6 <- additionDeDeuxMatricesBooleennes(graphtp3ex6, m2exo6)
additionexo6
m3exo6 <- produitDeDeuxMatricesBooleennes(m2exo6, graphtp3ex6)
additionexo6 <- additionDeDeuxMatricesBooleennes(additionexo6, m3exo6)
additionexo6
m4exo6 <- produitDeDeuxMatricesBooleennes(m3exo6, graphtp3ex6)
additionexo6 <- additionDeDeuxMatricesBooleennes(additionexo6, m4exo6)
additionexo6
m5exo6 <- produitDeDeuxMatricesBooleennes(m4exo6, graphtp3ex6)
additionexo6 <- additionDeDeuxMatricesBooleennes(additionexo6, m5exo6)
additionexo6

fermetureGraphiqueexo6 <- graph_from_adjacency_matrix(additionexo6, mode = "directed")
V(fermetureGraphiqueexo6)$name <- c("A", "B", "C", "D", "E", "F")
plot(fermetureGraphiqueexo6)

# TP3 EXERCICE 7
graphtp3ex7 <- matrix(c(0,0,1,0,0,
                        0,0,1,1,0,
                        0,0,0,1,0,
                        0,0,0,0,1,
                        0,0,0,0,0
), ncol = 5, byrow = TRUE)
GRAPHETP3EXO7 <- graph_from_adjacency_matrix(graphtp3ex7, mode = "directed")
plot(GRAPHETP3EXO7)

is_connected(GRAPHETP3EXO7, mode = "strong")
composantesGraphes7 <- components(GRAPHETP3EXO7, mode = "strong")

yfhiusdujfijlerdhfjhdfgozzjujrihgjfzeojihtgkzohggtjrfjiorehgiterfhuofdguri <- contract(GRAPHETP3EXO7, composantesGraphes7$membership, vertex.attr.comb = toString)
plot(yfhiusdujfijlerdhfjhdfgozzjujrihgjfzeojihtgkzohggtjrfjiorehgiterfhuofdguri)

m2exo7 <- produitDeDeuxMatricesBooleennes(graphtp3ex7, graphtp3ex7)
additionexo7 <- additionDeDeuxMatricesBooleennes(graphtp3ex7, m2exo7)
additionexo7
m3exo7 <- produitDeDeuxMatricesBooleennes(m2exo7, graphtp3ex7)
additionexo7 <- additionDeDeuxMatricesBooleennes(additionexo7, m3exo7)
additionexo7
m4exo7 <- produitDeDeuxMatricesBooleennes(m3exo7, graphtp3ex7)
additionexo7 <- additionDeDeuxMatricesBooleennes(additionexo7, m4exo7)
additionexo7
m5exo7 <- produitDeDeuxMatricesBooleennes(m4exo7, graphtp3ex7)
additionexo7 <- additionDeDeuxMatricesBooleennes(additionexo7, m5exo7)
additionexo7

fermetureGraphiqueexo7 <- graph_from_adjacency_matrix(additionexo7, mode = "directed")
V(fermetureGraphiqueexo7)$name <- c("A", "B", "C", "D", "E")
plot(fermetureGraphiqueexo7)