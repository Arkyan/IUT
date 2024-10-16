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

ajouterColonneDansTableDeVerite <- function(table,vecteur,nom){
    if(nrow(table) != length(vecteur)){
      print("Error")
      return(NA)
    }
  table[[nom]] <- vecteur
  return(table)
}

testAjoutTableDeVerite <- initialisationTableDeVerite(2, list("P","Q"))
unVecteur <- logical(nrow(testAjoutTableDeVerite))
testAjoutTableDeVerite <- ajouterColonneDansTableDeVerite(testAjoutTableDeVerite,unVecteur,"F")
testAjoutTableDeVerite

##########################################################################
############################### Exercice 3  ##############################
##########################################################################

connecteurLogiqueEt <- function(arg1, arg2){
  vec <- c()
  vec2 <- c()
  vec3 <- c()
  for(i in arg1){
      if(i == TRUE) {
            vec <- c(vec,TRUE)
          }
          else{
            vec <- c(vec,FALSE)
          }
  }
  print(vec)
  for(k in arg2){
    if(k == TRUE) {
      vec2 <- c(vec2,TRUE)
    }
    else{
      vec2 <- c(vec2,FALSE)
    }
  }
  print(vec2)
  for(m in 1:length(arg1)){
    if(vec[[m]] == TRUE){
      if(vec2[[m]] == TRUE){
        vec3 <- c(vec3, TRUE)
      }
      else{
        vec3 <- c(vec3, FALSE)
      }
    }
    else{
      vec3 <- c(vec3, FALSE)
    }
  }
  print(vec3)
  return(vec3)
}

unVecteur <- connecteurLogiqueEt(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, tableDeVerite[,1] & tableDeVerite[,2])

connecteurLogiqueOu <- function(arg1, arg2){
  vec <- c()
  vec2 <- c()
  vec3 <- c()
  for(i in arg1){
    if(i == TRUE) {
      vec <- c(vec,TRUE)
    }
    else{
      vec <- c(vec,FALSE)
    }
  }
  print(vec)
  for(k in arg2){
    if(k == TRUE) {
      vec2 <- c(vec2,TRUE)
    }
    else{
      vec2 <- c(vec2,FALSE)
    }
  }
  print(vec2)
  for(m in 1:length(arg1)){
    if(vec[[m]] == FALSE){
      if(vec2[[m]] == FALSE){
        vec3 <- c(vec3, FALSE)
      }
      else{
        vec3 <- c(vec3, TRUE)
      }
    }
    else{
      vec3 <- c(vec3, TRUE)
    }
  }
  print(vec3)
  return(vec3)
}

unVecteur <- connecteurLogiqueOu(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, tableDeVerite[,1] | tableDeVerite[,2])

connecteurLogiqueNon <- function(arg1){
  vec <- c()
  for(i in arg1){
    if(i == TRUE) {
      vec <- c(vec,FALSE)
    }
    else{
      vec <- c(vec,TRUE)
    }
  }
  print(vec)
  return(vec)
}

unVecteur <- connecteurLogiqueNon(tableDeVerite[,1])
all.equal(!unVecteur, tableDeVerite[,1])

##########################################################################
############################### Exercice 4  ##############################
##########################################################################

connecteurLogiqueOuexclu <- function(arg1, arg2){
  vec <- c()
  vec2 <- c()
  vec3 <- c()
  for(i in arg1){
    if(i == TRUE) {
      vec <- c(vec,TRUE)
    }
    else{
      vec <- c(vec,FALSE)
    }
  }
  print(vec)
  for(k in arg2){
    if(k == TRUE) {
      vec2 <- c(vec2,TRUE)
    }
    else{
      vec2 <- c(vec2,FALSE)
    }
  }
  print(vec2)
  for(m in 1:length(arg1)){
    if(vec[[m]] == FALSE){
      if(vec2[[m]] == FALSE){
        vec3 <- c(vec3, FALSE)
      }
      else{
        vec3 <- c(vec3, TRUE)
      }
    }
    else{
      if(vec2[[m]] == FALSE){
        vec3 <- c(vec3, TRUE)
      }
      else{
        vec3 <- c(vec3, FALSE)
      }
      
    }
  }
  print(vec3)
  return(vec3)
}

unVecteur <- connecteurLogiqueOuexclu(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, xor(tableDeVerite[,1], tableDeVerite[,2]))

connecteurLogiqueEquiv <- function(arg1, arg2){
  vec <- c()
  vec2 <- c()
  vec3 <- c()
  for(i in arg1){
    if(i == TRUE) {
      vec <- c(vec,TRUE)
    }
    else{
      vec <- c(vec,FALSE)
    }
  }
  print(vec)
  for(k in arg2){
    if(k == TRUE) {
      vec2 <- c(vec2,TRUE)
    }
    else{
      vec2 <- c(vec2,FALSE)
    }
  }
  print(vec2)
  for(m in 1:length(arg1)){
    if(vec[[m]] == vec2[[m]]){
        vec3 <- c(vec3, TRUE)
      }
      else{
        vec3 <- c(vec3, FALSE)
      }
  }
  print(vec3)
  return(vec3)
}

unVecteur <- connecteurLogiqueEquiv(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, tableDeVerite[,1] == tableDeVerite[,2])

connecteurLogiqueImpli <- function(arg1, arg2){
  vec <- c()
  vec2 <- c()
  vec3 <- c()
  for(i in arg1){
    if(i == TRUE) {
      vec <- c(vec,TRUE)
    }
    else{
      vec <- c(vec,FALSE)
    }
  }
  print(vec)
  for(k in arg2){
    if(k == TRUE) {
      vec2 <- c(vec2,TRUE)
    }
    else{
      vec2 <- c(vec2,FALSE)
    }
  }
  print(vec2)
  for(m in 1:length(arg1)){
    if(vec[[m]] == FALSE){
        vec3 <- c(vec3, TRUE)
      }
    else{
      if(vec2[[m]] == TRUE){
        vec3 <- c(vec3, TRUE)
      }
      else{
        vec3 <- c(vec3, FALSE)
      }
      
    }
  }
  print(vec3)
  return(vec3)
}

unVecteur <- connecteurLogiqueImpli(tableDeVerite[,1], tableDeVerite[,2])
all.equal(unVecteur, tableDeVerite[,1] -> tableDeVerite[,2]) 

##########################################################################
############################### Exercice 5  ##############################
##########################################################################

#1) (P => Q) ^ (Q => R) <=> (P => R) et (P => R) => (P => R)
#connecteurLogiqueEt(connecteurLogiqueImpli(P,Q), connecteurLogiqueImpli(Q,R))
#connecteurLogiqueImpli(P,R)
#2) non(P v Q) par la loi de De Morgan = non(P) ^ non(Q) 
#connecteurLogiqueEquiv(connecteurLogiqueNon(connecteurLogiqueOu(P, Q)),connecteurLogiqueEt(connecteurLogiqueNon(P), connecteurLogiqueNon(Q)))
#3) non(P ^ Q) par la loi de De Morgan = non(P) v non(Q)
#connecteurLogiqueEquiv(connecteurLogiqueNon(connecteurLogiqueEt(P, Q)),connecteurLogiqueOu(connecteurLogiqueNon(P), connecteurLogiqueNon(Q)))

##########################################################################
############################### Exercice 6  ##############################
##########################################################################
a544 <- connecteurLogiqueEquiv(tableDeVerite[,1], tableDeVerite[,2])
#
b544 <- connecteurLogiqueEquiv(tableDeVerite[,1],connecteurLogiqueNon(tableDeVerite[,2]))
#
c <- connecteurLogiqueOu(a544, b544)
#1)Valide

a544 <- connecteurLogiqueImpli(tableDeVerite[,1], tableDeVerite[,2])
#
b544 <- connecteurLogiqueImpli(tableDeVerite[,1],connecteurLogiqueNon(tableDeVerite[,2]))
#
c <- connecteurLogiqueOu(a544, b544)
#2)Valide

##########################################################################
############################### Exercice 7  ##############################
##########################################################################

#Tautologie
#Tautologie
#Tautologie
#Non
#Tautologie
#Non
#Non
#Tautologie