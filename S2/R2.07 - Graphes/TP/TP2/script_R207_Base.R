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



############################### Fonctions ###############################

#' Permet de trouver les cycles dans un graphe
#'
#' @param graphe 
#'
#' @returns les cycles du graphe
#' @export
#'
#' @examples
trouverCycles = function(graphe) {
  Cycles = NULL
  for(sommet1 in V(graphe)) {
    #Il faut que le degré entrant soit non nul sinon pas de boucle avec ce sommet
    if(degree(graphe, sommet1, mode="in") >= 1) {
      listeVoisins= neighbors(graphe, sommet1, mode="out")
      # On traite les sommets rangés après pas ceux avant car, si cycle/circuit, on les a déjà traités.
      listeVoisins = listeVoisins[listeVoisins > sommet1]
      for(sommet2 in listeVoisins) {
        cycleTemporaire = lapply(all_simple_paths(graphe, sommet2,sommet1, mode="out"), function(p) c(sommet1,p))
        # On élimine les cycles de longueur 2
        cycleTemporaire = cycleTemporaire[which(sapply(cycleTemporaire, length) > 3)]
        cycleTemporaire = cycleTemporaire[sapply(cycleTemporaire, min) == sapply(cycleTemporaire, `[`, 1)]
        Cycles  = c(Cycles, cycleTemporaire)
      }
    }
    else {}
  }
  Cycles
}




#' Création de l'arbre résultat d'un parcours  soit en profondeur soit en largeur
#'
#' @param graphe 
#' @param parcours 
#'
#' @returns l'arbre de parcours du graphe
#' @export
#'
#' @examples
creationArbreParcours <- function(graphe,parcours,estOriente=TRUE){
  #Récupération du vecteur père
  vecteurParcours <- parcours[["father"]]
  nomDesSommets <- V(graphe)$name
  # Récupérer les relations parent-enfant
  listeDesAretes <- na.omit(cbind(nomDesSommets[vecteurParcours], nomDesSommets))
  # Création du graphe
  constructionArbre <- graph_from_data_frame(d = listeDesAretes, directed = estOriente)
  return(constructionArbre)
}


#Exo 1 
#' Création de la matrice d'adjacence d'un graphe

matrice1 <- matrix(c(
    0,1,1,
    1,0,1,
    0,1,0), nrow = 3, byrow = TRUE)

#Mettre la matrice à la puissance 4
matrice1.2 <- produitDeDeuxMatrices(matrice1, matrice1)
matrice1.3 <- produitDeDeuxMatrices(matrice1.2, matrice1)
matrice1.4 <- produitDeDeuxMatrices(matrice1.3, matrice1)

print("Matrice 1 à la puissance 4")
print(matrice1.4)



#Exo 2 
matrice2 <- matrix(c(
    0,1,0,1,
    0,0,1,0,
    1,0,0,1,
    0,1,0,0), nrow = 4, byrow = TRUE)

matrice2.2 <- produitDeDeuxMatrices(matrice2, matrice2)
matrice2.3 <- produitDeDeuxMatrices(matrice2.2, matrice2)

print("Matrice 2")
print(matrice2)
print("Matrice 2 à la puissance 3")
print(matrice2.3)

#Exo 3
matrice3 <- matrix(c(
  0,0,0,0,0,0,0,1,1,
  0,0,0,0,0,0,1,0,0,
  0,0,0,0,0,1,0,1,1,
  0,0,0,0,0,0,1,1,0,
  0,0,0,0,0,1,1,0,1,
  0,0,1,0,1,0,1,0,1,
  0,1,0,1,1,1,0,0,1,
  1,0,1,1,0,0,0,0,0,
  1,0,1,0,1,1,1,0,0), nrow = 9, byrow = TRUE)

#Crée le graph
graphe3 <- graph_from_adjacency_matrix(matrice3, mode = "undirected")
plot(graphe3)

#Ordre du graph 
print("Ordre du graphe 3")
#print(order(graphe3))

#Connexité du graph
print("Connexité du graphe 3")
#print(is_connected(graphe3))

#Graph complet ?
print("Graphe complet ?")
#print(is_complete(graphe3))

#Chaine eulérienne ?
print("Chaine eulérienne ?")
#print(is_eulerian(graphe3))

#Déterminer M3 puissance 4
matrice3.2 <- produitDeDeuxMatrices(matrice3, matrice3)
matrice3.3 <- produitDeDeuxMatrices(matrice3.2, matrice3)
matrice3.4 <- produitDeDeuxMatrices(matrice3.3, matrice3)

print("Matrice 3 à la puissance 4")
print(matrice3.4)

#Exo 4
matrice4 <- matrix(c(
  0,15,0,0,0,3,0,
  15,0,21,25,0,0,10,
  0,21,0,20,0,0,0,
  0,25,20,0,10,0,17,
  0,0,0,10,0,0,15,
  30,0,0,0,0,0,20,
  0,10,0,17,15,20,0), nrow = 7, byrow = TRUE)

#Mettre matrice à puissance 4
matrice4.2 <- produitDeDeuxMatrices(matrice4, matrice4)
matrice4.3 <- produitDeDeuxMatrices(matrice4.2, matrice4)
matrice4.4 <- produitDeDeuxMatrices(matrice4.3, matrice4)

print("Matrice 4 à la puissance 4")
print(matrice4.4)





