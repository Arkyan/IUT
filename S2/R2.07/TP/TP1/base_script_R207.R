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

## EXO 1.2.a

edges <- matrix(c("A", "D", 
                  "B", "C", 
                  "B", "E", 
                  "C", "E",
                  "C", "D",
                  "F", "B",
                  "F", "D",
                  "F", "E"), 
                ncol = 2, byrow = TRUE)

g <- graph_from_edgelist(edges, directed = FALSE)
plot(g)

# Avec graph_from_adjacency_matrix
matrice_adjacence <- matrix(c(
  0, 0, 0, 1, 0, 0,  # A
  0, 0, 1, 0, 1, 1,  # B
  0, 1, 0, 1, 1, 0,  # C
  1, 0, 1, 0, 0, 1,  # D
  0, 1, 1, 0, 0, 1,  # E
  0, 1, 0, 1, 1, 0   # F
), nrow = 6, byrow = TRUE)

g_adj <- graph_from_adjacency_matrix(matrice_adjacence, mode = "undirected")
plot(g_adj)


#Avec graph_from_data_frame
df <- data.frame(
  from = c("A", "B", "B", "C", "C", "C", "F", "F", "F"),
  to = c("D", "C", "E", "E", "D", "F", "B", "D", "E")
)

g_df <- graph_from_data_frame(df, directed = FALSE)
plot(g_df)

#Avec graph_from_literal
g_lit <- graph_from_literal(A--D, B--C, B--E, C--E, C--D, F--B, F--D, F--E)
plot(g_lit)

## EXO 1.2.b
num_amitie <- gsize(g)
print(num_amitie)

## EXO 1.2.d
degres <- degree(g)
degre_moyen <- mean(degres)
print(degre_moyen)

## EXO 2.a
m2_adj <- matrix(c(
  0,1,1,1,1,0,
  1,0,0,1,1,1,
  1,0,0,1,0,0,
  0,0,1,0,0,1,
  1,1,0,0,0,0,
  1,0,1,0,1,0
  ), nrow = 6, byrow = TRUE)
g2_adj <- graph_from_adjacency_matrix(m2_adj, mode = "directed")

# Ajout des noms aux sommets
V(g2_adj)$name <- c("So", "Lu", "Em", "Th", "Léa", "Ma")
plot(g2_adj)

#Exo 2.b
# Calcul degré entrant et sortant
degre_entrant <- degree(g2_adj, mode = "in")
degre_sortant <- degree(g2_adj, mode = "out")
degree <- degree(g2_adj)

print(degre_entrant)
print(degre_sortant)
print(degree)


#Exo 2.c
# Calcul de la matrice d'adjacence
m2_adj <- get.adjacency(g2_adj, sparse = FALSE)
print(m2_adj)

#Calculer les degrés int ext et total via la matrice d'adjacence
degre_int <- rowSums(m2_adj)
degre_ext <- colSums(m2_adj)
degre_total <- degre_int + degre_ext

print(degre_int)
print(degre_ext)
print(degre_total)

#Exo 2.d
#Donner les excentricités de chaque sommet 

excentricite <- eccentricity(g2_adj)
print(excentricite)

#Exo 2.e
#Donner le diamètre du graphe et le centre
diametre <- diameter(g2_adj)
print(diametre)

centre <- which(excentricite == min(excentricite))
print(centre)

#Exo 3.1
m3_adj <- matrix(c(
  0,0,20,0,0,0,0,
  0,0,2,0,0,6,0,
  20,2,0,8,0,0,0,
  0,0,8,0,10,0,0,
  0,0,0,10,0,12,0,
  0,6,0,0,12,0,1,
  0,0,0,0,0,1,0
  ), nrow = 7, byrow = TRUE)

g3_adj <- graph_from_adjacency_matrix(m3_adj, mode = "undirected", weighted = TRUE)

V(g3_adj)$name <- c("0", "1", "2", "3", "4", "5","6")

plot(g3_adj, edge.label = E(g3_adj)$weight, vertex.label = V(g3_adj)$name, vertex.size = 30, main = "Titre")

#Exo 3.4
m4_adj <- matrix(c(
  0,1,1,1,1,0,
  1,0,0,1,1,1,
  1,0,0,1,0,0,
  0,0,1,0,0,1,
  1,1,0,0,0,0,
  1,0,1,0,1,0
  ), nrow = 6, byrow = TRUE)



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