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



library(igraph)

find_eulerian_path <- function(graph) {
  # Vérifier la connectivité en tenant compte de l'orientation
  if (!is_connected(graph, mode = "weak")) {
    return(NULL)  # Pas de chemin eulérien si le graphe n'est pas faiblement connexe
  }
  
  # Calcul des degrés entrants et sortants
  in_deg <- degree(graph, mode = "in")
  out_deg <- degree(graph, mode = "out")
  
  # Identifier les sommets avec déséquilibre entrant/sortant
  start_vertex <- NULL
  end_vertex <- NULL
  for (v in V(graph)) {
    diff <- out_deg[v] - in_deg[v]
    if (diff == 1) {
      if (!is.null(start_vertex)) return(NULL)  # Plus d'un sommet de départ → pas de chemin eulérien
      start_vertex <- v
    } else if (diff == -1) {
      if (!is.null(end_vertex)) return(NULL)  # Plus d'un sommet d'arrivée → pas de chemin eulérien
      end_vertex <- v
    } else if (diff != 0) {
      return(NULL)  # Si un sommet a un déséquilibre autre que ±1 → pas de chemin eulérien
    }
  }
  
  # Si aucun sommet de départ identifié, prendre un sommet arbitraire
  if (is.null(start_vertex)) {
    start_vertex <- V(graph)[1]
  }
  
  # Copie du graphe
  g <- graph
  path <- c()
  
  # Fonction récursive pour trouver le chemin eulérien
  eulerian_helper <- function(v) {
    while (degree(g, v, mode = "out") > 0) {
      edges <- incident(g, v, mode = "out")  # Arêtes sortantes
      next_edge <- edges[1]  # Première arête disponible
      next_vertex <- ends(g, next_edge)[2]  # Sommet cible
      
      g <<- delete_edges(g, next_edge)  # Supprimer l'arête parcourue
      eulerian_helper(next_vertex)  # Continuer le parcours
    }
    path <<- c(v, path)  # Ajouter le sommet au chemin final
  }
  
  eulerian_helper(start_vertex)
  return(path)
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
#plot(graphe3)

#Ordre du graph 
print("Ordre du graphe 3")
#print(order(graphe3))

#Connexité du graph
print("Connexité du graphe 3")
print(is_connected(graphe3))

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
print("M4-6 correspond à ........")

#Exo 5
#Graphe G1
adj_G1 <- matrix(c(
  0, 1, 1, 0, 0, 0,
  0, 0, 0, 1, 1, 0,
  0, 0, 0, 1, 1, 0,
  0, 0, 0, 0, 0, 1,
  0, 0, 0, 0, 0, 1,
  0, 1, 0, 0, 0, 0
), nrow=6, byrow=TRUE)

#Graphe G2
adj_G2 <- matrix(c(
  0, 1, 0, 0, 0, 0,
  0, 0, 1, 0, 0, 0,
  0, 0, 0, 1, 0, 0,
  0, 0, 0, 0, 1, 0,
  0, 1, 0, 0, 0, 1,
  1, 0, 1, 0, 0, 0
), nrow=6, byrow=TRUE)

#Graphe G3
adj_G3 <- matrix(c(
  0, 0, 0, 0, 0,
  0, 0, 0, 1, 1,
  0, 1, 0, 1, 0,
  1, 0, 0, 0, 0,
  1, 0, 0 ,0, 0
), nrow=5, byrow=TRUE)


#Graphe G4
adj_G4 <- matrix(c(
  0, 1, 0, 0, 0, 0,
  1, 0, 0, 1, 0, 1,
  0, 0, 0, 0, 0, 1,
  0, 0, 0, 0, 1, 0,
  0, 0, 1, 0, 0, 0,
  1, 0, 0, 0, 0, 0
), nrow=6, byrow=TRUE)




#G1 ordre
g1 <- graph_from_adjacency_matrix(adj_G1, mode="directed")
V(g1)$name <- c("A", "B", "C", "D", "E", "F")
plot(g1)
print("G1 ordre")
print(gorder(g1))
print("G1 connexité")
print(is_connected(g1, mode="strong"))
print("G1 circuit")
print(trouverCycles(g1))
print("Chemin eulérien")
print(find_eulerian_path(g1))

#G2 ordre
g2 <- graph_from_adjacency_matrix(adj_G2, mode="directed")
V(g2)$name <- c("A", "B", "C", "D", "E", "F")
plot(g2)
print("G2 ordre")
print(gorder(g2))
print("G2 connexité")
print(is_connected(g2, mode="strong"))
print("G2 circuit")
print(trouverCycles(g2))
print("Chemin eulérien")
print(find_eulerian_path(g2))

#G3 ordre
g3 <- graph_from_adjacency_matrix(adj_G3, mode="directed")
V(g3)$name <- c("A", "B", "C", "D", "E")
plot(g3)
print("G3 ordre")
print(gorder(g3))
print("G3 connexité")
print(is_connected(g3, mode="strong"))
print("G3 circuit")
print(trouverCycles(g3))
print("Chemin eulérien")
print(find_eulerian_path(g3))

#G4 ordre
g4 <- graph_from_adjacency_matrix(adj_G4, mode="directed")
V(g4)$name <- c("A", "B", "C", "D", "E", "F")
plot(g4)
print("G4 ordre")
print(gorder(g4))
print("G4 connexité")
print(is_connected(g4, mode="strong"))
print("G4 circuit")
print(trouverCycles(g4))
print("Chemin eulérien")
print(find_eulerian_path(g4))

#Exercice 6
matrice6 <- matrix(c(0, 1, 0, 0, 
                     1, 2, 1, 0,
                     0, 0, 1, 1,
                     0, 0, 0, 0), nrow = 4, byrow=TRUE)

#Affichage de la matrice initiale
print("Matrice initiale")
print(matrice6)

#Multiplication de la matrice par elle-même
resultat <- produitDeDeuxMatrices(matrice6, matrice6)
resultat2 <- produitDeDeuxMatrices(matrice6, resultat)
resultat3 <- produitDeDeuxMatrices(matrice6, resultat2)

#Affichage du résultat
print("Résultat de la multiplication")
print(resultat3)

#Exercice 7
matrice7 <- matrix(c(
  0, 0, 0, 0, 1, 0,
  1, 0, 1, 0, 0, 1,
  1, 1, 0, 1, 0, 0,
  1, 0, 0, 0, 0, 0,
  0, 0, 0, 1, 0, 0,
  0, 0, 1, 0, 1, 0), nrow=6, byrow=TRUE)

#Affichage de la matrice initiale
print("Matrice initiale")
print(matrice7)
g5 <- graph_from_adjacency_matrix(matrice7, mode="directed")
V(g5)$name <- c("A", "B", "C", "D", "E", "F")
plot(g5)


#Multiplication de la matrice par elle-même
resultat <- produitDeDeuxMatrices(matrice7, matrice7)
resultat2 <- produitDeDeuxMatrices(matrice7, resultat)

print("Résuktat de la multiplication")
print(resultat2)
  