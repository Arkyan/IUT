##########################################################################
## Installation de package et chargement du package, si nécessaire #######
##########################################################################
# if (!require("matlib")) {
#   install.packages("matlib")  
# }
# library(matlib)

##########################################################################
############################### Exercise 1  ##############################
##########################################################################

creationEnsemble <- function(...) {
  return(unique(c(...)))
}

ensemble1 <- creationEnsemble(1,2,3,4)
ensemble1 
ensemble2 <- creationEnsemble("A","B", "C", "a","b", "c")
ensemble2
ensemble3 <- creationEnsemble()
ensemble3
ensemble4 <- creationEnsemble(1:4, 1:4, 5,5,6)
ensemble4


##########################################################################
############################### Exercise 2  ##############################
##########################################################################

unionDeDeuxEnsembles <- function(ensembleA, ensembleB){
  return(unique(c(ensembleA,ensembleB)))
}

ensemble1Et1 <- unionDeDeuxEnsembles(ensembleA = ensemble1, ensembleB = ensemble1)
ensemble1Et2 <- unionDeDeuxEnsembles(ensembleA = ensemble1, ensembleB = ensemble2)
ensemble1Et3 <- unionDeDeuxEnsembles(ensembleA = ensemble1, ensembleB = ensemble3)
ensemble1Et4 <- unionDeDeuxEnsembles(ensembleA = ensemble1, ensembleB = ensemble4)
ensemble2Et2 <- unionDeDeuxEnsembles(ensembleA = ensemble2, ensembleB = ensemble2)
ensemble2Et3 <- unionDeDeuxEnsembles(ensembleA = ensemble2, ensembleB = ensemble3)
ensemble2Et4 <- unionDeDeuxEnsembles(ensembleA = ensemble2, ensembleB = ensemble4)
ensemble3Et3 <- unionDeDeuxEnsembles(ensembleA = ensemble3, ensembleB = ensemble3)
ensemble3Et4 <- unionDeDeuxEnsembles(ensembleA = ensemble3, ensembleB = ensemble4)
ensemble4Et4 <- unionDeDeuxEnsembles(ensembleA = ensemble4, ensembleB = ensemble4)
ensemble1Et1
ensemble1Et2
ensemble1Et3
ensemble1Et4
ensemble2Et2
ensemble2Et3
ensemble2Et4
ensemble3Et3
ensemble3Et4
ensemble4Et4
setequal(ensemble1Et2, union(x=ensemble1,y=ensemble2))
setequal(ensemble2Et4, union(x=ensemble2,y=ensemble4))

##########################################################################
############################### Exercice 3  ##############################
##########################################################################

intersectionDeDeuxEnsembles <- function(ensembleA, ensembleB) {
  resultat <- c()  
  for (element in ensembleA) {  
    if (element %in% ensembleB) {
      resultat <- c(resultat, element)  
    }
  }
  return(unique(resultat))  
}
  

ensemble1112 <- intersectionDeDeuxEnsembles(ensembleA = ensemble1Et1, ensembleB = ensemble1Et2)
ensemble1222 <- intersectionDeDeuxEnsembles(ensembleA = ensemble1Et2, ensembleB = ensemble2Et2)
ensemble1112
ensemble1222
setequal(ensemble1112, intersect(x=ensemble1Et1, y=ensemble1Et2))
setequal(ensemble1222, intersect(x=ensemble1Et2, y=ensemble2Et2))
ensemble1112bis <- intersectionDeDeuxEnsembles(ensembleB = ensemble1Et1, ensembleA = ensemble1Et2)
setequal(ensemble1112bis, ensemble1112)

##########################################################################
############################### Exercice 4  ##############################
##########################################################################

differenceDeDeuxEnsembles <- function(ensembleA,ensembleB){
  resultat <- c()  
  for (element in ensembleA) {  
    if (!(element %in% ensembleB)) {
       resultat <- c(resultat, element)  
    }
  }
  return(unique(resultat))  
}

ensemble11Diff12 <- differenceDeDeuxEnsembles(ensembleA = ensemble1Et1, ensembleB = ensemble1Et2)
ensemble12Diff11 <- differenceDeDeuxEnsembles(ensembleB = ensemble1Et1, ensembleA = ensemble1Et2)
ensemble11Diff14 <- differenceDeDeuxEnsembles(ensembleA = ensemble1Et1, ensembleB = ensemble1Et4)
ensemble24Diff11 <- differenceDeDeuxEnsembles(ensembleA = ensemble2Et4, ensembleB = ensemble1Et1)

ensemble11Diff12
ensemble12Diff11
ensemble11Diff14
ensemble24Diff11

setequal(ensemble11Diff12, setdiff(x= ensemble1Et1, y = ensemble1Et2))
setequal(ensemble12Diff11, setdiff(y= ensemble1Et1, x = ensemble1Et2))
setequal(ensemble11Diff14, setdiff(x= ensemble1Et1, y = ensemble1Et4))
setequal(ensemble24Diff11, setdiff(x= ensemble2Et4, y = ensemble1Et1))



differenceSymetriqueDeDeuxEnsembles <- function(ensembleC,ensembleD){
  diffAB <- differenceDeDeuxEnsembles(ensembleC,ensembleD)
  diffBA <- differenceDeDeuxEnsembles(ensembleD,ensembleC)
  return(unique(c(diffAB,diffBA)))
}

ensemble5 <- creationEnsemble(1:4,8:10)
ensemble5Diff24 <- differenceSymetriqueDeDeuxEnsembles(ensembleC = ensemble5, ensembleD = ensemble2Et4)
ensemble5Diff24

##########################################################################
############################### Exercise 5  ##############################
##########################################################################

complementaireDUnEnsemble <- function(ensembleE,ensembleF){
  
  if (is.null(intersectionDeDeuxEnsembles(ensembleE,ensembleF))){
    return("Erreur")}
  else {
    resultat <- c()  
    for (element in ensembleF) {  
       if (!(element %in% ensembleE)) {
           resultat <- c(resultat, element)  
      }
    }
  return(unique(resultat))  
  }
}

ensemble11Comp24 <- complementaireDUnEnsemble(ensembleE= ensemble1Et1, ensembleF = ensemble2Et4)
ensemble11Comp24
ensemble11Comp22 <- complementaireDUnEnsemble(ensembleE=ensemble1Et1, ensembleF=ensemble2Et2)
ensemble11Comp22

##########################################################################
############################### Exercise 6  ##############################
##########################################################################

cardinalDUnEnsemble <- function(ensemble){
  return(length(ensemble))
}
  
ensemble1
cardinalDUnEnsemble(ensemble1)
ensemble2
cardinalDUnEnsemble(ensemble2)
ensemble3
cardinalDUnEnsemble(ensemble3)
ensemble4
cardinalDUnEnsemble(ensemble4)

##########################################################################
############################### Exercise 7  ##############################
##########################################################################

produitCartesienDeDeuxEnsembles <- function(ensembleA,ensembleB){
  resultat <- list()
  index <- 1
  for (a in ensembleA){
    for (b in ensembleB){
      resultat[[index]] <- c(a,b)
      index <- index + 1
    }
  }
  return (resultat)
}
    


ensembleProduit12 <- produitCartesienDeDeuxEnsembles(ensembleA = ensemble1, ensembleB = ensemble2)
ensembleProduit12
ensembleProduit12bis <- expand.grid(ensemble1,ensemble2)
ensembleProduit12bis 

