##########################################################################
## Installation de package et chargement du package, si nécessaire #######
##########################################################################
# if (!require("matlib")) {
#   install.packages("matlib")  
# }
# library(matlib)

##########################################################################
############################### Exercice 1  ##############################
##########################################################################

initialisationTableDeVerite <- function(nombreVariables,nomDesVariables){
  if (nombreVariables <=0 | nombreVariables != length(nomDesVariables)){
    print("erreur de saisie")
    return(NA)
  }
  else{
    resultat <-numeric(2^nombreVariables)
    for (compteur in 0:(nombreVariables-1) ){
      intermediaire <- rep( c(rep(FALSE,2^compteur),rep(TRUE,2^compteur)),2^(nombreVariables-1-compteur))
      resultat <- data.frame(intermediaire, resultat)
    }
    names(resultat)<- append(nomDesVariables,"none")
    return(resultat[-(nombreVariables+1)])
  }
}

tableDeVerite <- initialisationTableDeVerite(0, list("a","b","c","d"))
tableDeVerite
tableDeVerite <- initialisationTableDeVerite(5, list("a","b","c","d"))
tableDeVerite
tableDeVerite <- initialisationTableDeVerite(3, list("a","b","c"))
tableDeVerite
tableDeVerite <- initialisationTableDeVerite(4, list("a","b","c","d"))
tableDeVerite


##########################################################################
############################### Exercice 2  ##############################
##########################################################################

ajouterColonneDansTableDeVerite <- function(tableVerite, ColonneAAjouter,nomColonne){
  tableVerite <- data.frame(tableVerite, ColonneAAjouter)
names(tableVerite)[length(tableVerite)] <- nomColonne
return(tableVerite)  
}
testAjoutTableDeVerite <- initialisationTableDeVerite(2, list("P", "Q"))
unVecteur <- logical(nrow(testAjoutTableDeVerite))
testAjoutTableDeVerite <- ajouterColonneDansTableDeVerite(testAjoutTableDeVerite,unVecteur, "F")
testAjoutTableDeVerite

##########################################################################
############################### Exercice 3  ##############################
##########################################################################

connecteurLogiqueET <- function(a,b){
  #fait le calcul logique et en mode sequentiel
  d <-logical(0)
  for (i in 1:length(a) ) {
    if (a[i] & b[i]){
      d<- c(d, TRUE)
    } 
    else {
      d <- c(d,FALSE)
    }
  }
  return(d)
}


unVecteur <- connecteurLogiqueET(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, tableDeVerite[,1] & tableDeVerite[,2] )


connecteurLogiqueNegation <- function(a){
  #fait le calcul logique et en mode sequentiel 
  d <-logical(0)
  for (i in 1:length(a) ) {
    if (!a[i]){
      d<- c(d, TRUE)
    } 
    else {
      d <- c(d,FALSE)
    }
  }
  return(d)
}



