##########################################################################
## Installation de package et chargement du package, si nécessaire #######
##########################################################################
if (!require("polynom")) {
  install.packages("polynom")
}
library(polynom)

##########################################################################
############################### Exercice 1  ##############################
##########################################################################

#' Fonction pour rechercher dans une liste l'indice d'un couple suivant la valeur d'une coordonnée.
#'
#' @param uneListe
#' @param indiceCoordoonee
#' @param valeurRecherchee
#'
#' @return un vecteur logique ayant pour valeur True le/les couple(s) recherché(s)
#' @export
#'
#' @examples
#' p <- list(c(2, 5), c(-1, 4), c(-2, 1), c(0, 3), c(3, 0))
#' position <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(p,1,100)
rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee <- function(uneListe,
                                                                     indiceCoordoonee,
                                                                     valeurRecherchee) {
  # Vérifier que l'index de la coordonnée est valide
  if (indiceCoordoonee %in% c(1, 2)) {
    vecteurLogiqueDeLaRecherche <- sapply(uneListe, function(x)
      x[indiceCoordoonee] == valeurRecherchee)
    indiceDuCouple <-  which(vecteurLogiqueDeLaRecherche)
  } else{
    print("Erreur. L'index de la coordonnée doit être 1 ou 2.")
    indiceDuCouple <- integer(0)
  }
  return(indiceDuCouple)
}

uneListe <- list(c(2, 5), c(-1, 4), c(-2, 1), c(0, 3), c(3, 0), c(-7, 4))
uneListe
positionRecherche100 <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(uneListe, 1, 100)
positionRecherche100
positionRecherche3 <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(uneListe, 2, 3)
positionRecherche3
positionRecherche4 <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(uneListe, 2, 4)
positionRecherche4
positionRecherche5 <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(uneListe, 3, 5)
positionRecherche5


##########################################################################
############################### Exercice 2  ##############################
##########################################################################

#' Déterminer si le poylnôme est le polynôme nul ou non;
#' On suppose ici qu'il n'y a pas deux couples qui ont le même monome.
#'
#' @param unPolynome
#'
#' @return True si le polynôme unpolynome est le polynôme nul, False sinon.
#' @export
#'
#' @examples
#' unPolynome <- creationPolynome(c(0,0))
#' valeurLogique <- estLePolynomeNul(unPolynome)
estLePolynomeNul <- function(unPolynome) {
  return(length(unPolynome) == 0)
}



#' Supprime les coefficients nuls dans un polynome
#'
#' @param polynomeConstruit
#'
#' @return un polynome n'ayant que des coefficients non nuls
#' @export
#'
#' @examples
suppressionCoefficientNul <- function(unPolynome) {
  polynomeSimplifie <- unPolynome
  if (!estLePolynomeNul(unPolynome)) {
    listeDesMonomesNuls <- rechercheIndiceDUnCoupleDansUneListeSuivantUneCoordonnee(
      uneListe = unPolynome,
      indiceCoordoonee = 1,
      valeurRecherchee = 0
    )
    if (length(listeDesMonomesNuls) != 0) {
      polynomeSimplifie <-  unPolynome[-listeDesMonomesNuls]
    } else{
      
    }
  } else{
    
  }
  return(polynomeSimplifie)
}


#' Création d'un polynôme creux à l'aide d'un vecteur de valeur contenant le
#' coefficient du monôme et la puissance du monôme.
#'
#' @param unVecteurDeValeurs
#'
#' @return un polynome construit en liste ayant des couples de (coeffMonome, degreMonome)
#' @export
#'
#' @examples
#' premierPolynome <- creationPolynome(c(2, 5,-1, 4,-2, 1,0, 3, 3, 0))
creationPolynome <- function(unVecteurDeValeurs) {

}

premierPolynome <- creationPolynome(c(-1, 8, -2, 1, 0, 3, 2, 10, 3, 0))
premierPolynome
secondPolynome <- creationPolynome(c(0, 0))
secondPolynome
troisiemePolynome <- creationPolynome(c(2, 10, -2, 10, -2, 5, 4, 0, 3, 0))
troisiemePolynome
unMonome <-  creationPolynome(c(1, 15))
unMonome

listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, estLePolynomeNul)

##########################################################################
############################### Exercice 3  ##############################
##########################################################################

#' Déterminer si le poylnôme est le polynôme nul ou non;
#' On suppose ici qu'il n'y a pas deux couples qui ont le même monome.
#'
#' @param unPolynome
#'
#' @return True si le polynôme unpolynome est le polynôme nul, False sinon.
#' @export
#'
#' @examples
#' unPolynome <- creationPolynome(c(0,0))
#' valeurLogique <- estLePolynomeNul(unPolynome)
estLePolynomeNul <- function(unPolynome) {
  return(length(unPolynome) == 0)
}

listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, estLePolynomeNul)

estLePolynomeNul(premierPolynome)
estLePolynomeNul(secondPolynome)
estLePolynomeNul(troisiemePolynome)
estLePolynomeNul(unMonome)

##########################################################################
############################### Exercice 4  ##############################
##########################################################################

#' Déterminer le degré d'un polynome ou d'un monome.
#'
#' @param unPolynome
#'
#' @return le degré d'un polynome ou d'un monone unpolynome.
#' @export
#'
#' @examples
#' degrePolynome1 <- degrePolynome(premierPolynome)
degrePolynome <- function(unPolynome) {

}

listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, degrePolynome)

degrePolynome1 <- degrePolynome(premierPolynome)
degrePolynome1
degrePolynome2 <- degrePolynome(secondPolynome)
degrePolynome2
degrePolynome3 <- degrePolynome(troisiemePolynome)
degrePolynome3
degreMonome <- degrePolynome(unMonome)
degreMonome

#' Déterminer le coefficient d'un monôme et uniquement d'un monôme.
#' cela ne fonctionne pas avec un polynôme.
#'
#' @param unMonome
#'
#' @return le coefficient du monôme unMonome.
#' @export
#'
#' @examples
coefficientMonome <- function(unMonome) {

  }
}
listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, coefficientMonome)

coefficientPolynome1 <- coefficientMonome(premierPolynome)
coefficientPolynome1
coefficientPolynome2 <- coefficientMonome(secondPolynome)
coefficientPolynome2
coefficientPolynome3 <- coefficientMonome(troisiemePolynome)
coefficientPolynome3
coefficientUnMonome <- coefficientMonome(unMonome)
coefficientUnMonome

##########################################################################
############################### Exercice 5  ##############################
##########################################################################

#' Affiche le polynome sous la forme lisble
#'
#' @param unPolynome
#'
#' @return affichage du polynome de façon lisible
#' @export
#'
#' @examples
#' affichagePolynome(premierPolynome)
affichagePolynome <- function(unPolynome) {

  }

listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, affichagePolynome)

#' Trie les monomes d'un polynome pour l'afficher suivant les puissances décroissantes
#'
#' @param unPolynome
#'
#' @return un polynom trié suivant les puissances décroissantes
#' @export
#'
#' @examples
trierPolynome <- function(unPolynome) {
  
  }

premierPolynomeTrie <- trierPolynome(premierPolynome)
affichagePolynome(premierPolynomeTrie)

#### modification de la fonction de construction d'un polynôme creux  ####

#' Création d'un polynôme creux à l'aide d'un vecteur de valeur contenant le
#' coefficient du monôme et la puissance du monôme.
#'
#' @param unVecteurDeValeurs
#'
#' @return un polynome construit en liste ayant des couples de (coeffMonome, degreMonome)
#' @export
#'
#' @examples
#' premierPolynome <- creationPolynome(c(2, 5,-1, 4,-2, 1,0, 3, 3, 0))
creationPolynome <- function(unVecteurDeValeurs) {
 
}

premierPolynome <- creationPolynome(c(-1, 8, -2, 1, 0, 3, 2, 10, 3, 0))
secondPolynome <- creationPolynome(c(0, 0))
troisiemePolynome <- creationPolynome(c(2, 10, -2, 10, -2, 5, 4, 0, 3, 0))
unMonome <-  creationPolynome(c(1, 15))
listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
lapply(listePourAffichage, affichagePolynome)

##########################################################################
############################### Exercice 6  ##############################
##########################################################################

#' Somme de deux monômes de même degre
#'
#' @param monomeA
#' @param monomeB
#'
#' @return monomeA+ monomeB
#' @export
#'
#' @examples
additionDeDeuxMonomes <- function(monomeA, monomeB) {

  }


#' Elimine les monomes doublons dans le polynôme résultat et le laisse trié
#'
#' @param unPolynome
#'
#' @return un polynôme simplifié sans plusieur fois un monome de même degré
#' @export
#'
#' @examples
simplifierDoublons <- function(unPolynome) {
 
  
}
#' Simplifie un polynome, en triant le polynome suivant les puissances décroissantes
#' en supprimant les monômes doublons et en supprimant les monomes ayant un  coefficient nul
#'
#' @param unPolynome
#'
#' @return
#' @export
#'
#' @examples
simplifierPolynome <- function(unPolynome) {
 
}

#' Addition de deux polynômes
#'
#' @param polynomeA
#' @param polynomeB
#'
#' @return polynomeA + polynomeB
#' @export
#'
#' @examples
additionDeDeuxPolynomes <- function(polynomeA, polynomeB) {
 
}

liste1 <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
liste2 <- list(secondPolynome, troisiemePolynome, unMonome, premierPolynome)
mapply(additionDeDeuxPolynomes, liste1, liste2)

polynomeResultat <- additionDeDeuxPolynomes(premierPolynome, troisiemePolynome)
polynomeResultat
affichagePolynome(premierPolynome)
affichagePolynome(troisiemePolynome)
affichagePolynome(polynomeResultat)

affichagePolynome(polynomeResultat <- additionDeDeuxPolynomes(secondPolynome, secondPolynome))





##########################################################################
############################### Exercice 7  ##############################
##########################################################################

#' Multiplication d'un polynome par un scalaire
#'
#' @param unPolynome
#' @param scalaire
#'
#' @return unPolynome x scalaire
#' @export
#'
#' @examples
#' premierPolynomeMultipliePar3 <- multiplicationParUnScalaire(premierPolynome, 3)
multiplicationParUnScalaire <- function(unPolynome, scalaire) {
  
}

premierPolynomeMultipliePar3 <- multiplicationParUnScalaire(premierPolynome, 3)
secondPolynomeMultipliePar2 <- multiplicationParUnScalaire(secondPolynome, 2)
troisiemePolynomeMultipliePar0 <- multiplicationParUnScalaire(troisiemePolynome, 0)
unMonomeMultiplieParMoins7 <- multiplicationParUnScalaire(unMonome, -7)

listePourAffichage <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
scalaire <- c(3, 2, 0, -7)
listeAAfficher <- mapply(multiplicationParUnScalaire, listePourAffichage, scalaire)
lapply(listeAAfficher, affichagePolynome)
listePourAffichage <- list(
  premierPolynome,
  premierPolynomeMultipliePar3,
  secondPolynome,
  secondPolynomeMultipliePar2,
  troisiemePolynome,
  troisiemePolynomeMultipliePar0,
  unMonome,
  unMonomeMultiplieParMoins7
)
lapply(listePourAffichage, affichagePolynome)


#' Soustraction de deux polynômes
#'
#' @param polynomeA
#' @param polynomeB
#'
#' @return polynomeA - polynomeB
#' @export
#'
#' @examples
soustractionDeDeuxPolynomes <- function(polynomeA, polynomeB) {
 
}
liste1 <- list(premierPolynome, secondPolynome, troisiemePolynome, unMonome)
liste2 <- list(secondPolynome, troisiemePolynome, unMonome, premierPolynome)
lapply(liste1, affichagePolynome)
lapply(liste2, affichagePolynome)
lapply(mapply(soustractionDeDeuxPolynomes, liste1, liste2),
       affichagePolynome)
lapply(mapply(soustractionDeDeuxPolynomes, liste2, liste1),
       affichagePolynome)

affichagePolynome(polynomeResultat <- soustractionDeDeuxPolynomes(secondPolynome, secondPolynome))


#' Produit de deux monomes
#'
#' @param monomeA
#' @param monomeB
#'
#' @return monomesA x monomesB
#' @export
#'
#' @examples
produitDeDeuxMonomes <- function(monomeA, monomeB) {
 
}

affichagePolynome(produitDeDeuxMonomes(unMonome[[1]], unMonome[[1]]))

##########################################################################
############################### Exercice 8  ##############################
##########################################################################

#' Produit d'un polynome par un monome
#'
#' @param unPolynome
#' @param unMonome
#'
#' @return unPolynome * unMonome, polynome simplifié et ordonné suivant les puissances décroissantes.
#' @export
#'
#' @examples
produitDUnPolynomeParUnMonome <- function(unPolynome, unMonome) {
 
}

affichagePolynome(produitDUnPolynomeParUnMonome(premierPolynome, unMonome))
affichagePolynome(produitDUnPolynomeParUnMonome(premierPolynome, secondPolynome))

produitDeDeuxPolynomes <- function(polynomeA, polynomeB) {

}

affichagePolynome(produitDeDeuxPolynomes(premierPolynome, unMonome))
affichagePolynome(produitDeDeuxPolynomes(premierPolynome, secondPolynome))
affichagePolynome(premierPolynome)
affichagePolynome(troisiemePolynome)
affichagePolynome(produitDeDeuxPolynomes(premierPolynome, troisiemePolynome))
affichagePolynome(produitDeDeuxPolynomes(troisiemePolynome, premierPolynome))


##########################################################################
############################### Exercices 9  et 10 #######################
##########################################################################
#' Conversion d'un polynôme normal en polynôme creux
#'
#' @param unPolynome 
#'
#' @return unPolynome sous forme de liste (coef, degre)
#' @export 
#'
#' @examples
conversionPolynomeNormalEnPolynomeCreux <- function(unPolynome){
  

}

polynomeP <- creationPolynome(c(-5,20,12,14,7,10,5,2,3,0))
P <- polynomial(c(3,0,5,0,0,0,0,0,0,0,7,0,0,0,12,0,0,0,0,0,-5))
affichagePolynome(polynomeP)
P
convertionPolyP <- conversionPolynomeNormalEnPolynomeCreux(P)
affichagePolynome(convertionPolyP)


#' Conversion d'un polynome creux en polynôme normal 
#'
#' @param unPolynome 
#'
#' @return UnPolynome sous forme normale
#' @export
#'
#' @examples
conversionPolynomeCreuxEnPolynomeNormal <- function(unPolynome){

}

PNormal <- conversionPolynomeCreuxEnPolynomeNormal(polynomeP)
PNormal
affichagePolynome(polynomeP)



polynomeP <- creationPolynome(c(-5,20,12,14,7,10,5,2,3,0))
P <-  conversionPolynomeCreuxEnPolynomeNormal(polynomeP)
  
polynomeQ <- creationPolynome(c(5,20,-8,14,-5,12,10,7,-3,2))
Q <-  conversionPolynomeCreuxEnPolynomeNormal(polynomeQ)

polynomeR <- creationPolynome(c(7,15,-9,14,6,13,1,11,2,8,-15,0))
R <-  conversionPolynomeCreuxEnPolynomeNormal(polynomeR)

polynomeS <- creationPolynome(c(6,14,6,12,1,11,10,7,-3,2,12,0))
S <-  conversionPolynomeCreuxEnPolynomeNormal(polynomeS)

lapply(list(polynomeP, polynomeQ, polynomeR, polynomeS), affichagePolynome)
lapply(list(P,Q,R,S), function(x) print(x , decreasing = TRUE))

affichagePolynome(additionDeDeuxPolynomes(polynomeA = polynomeP, polynomeB = polynomeQ))
print(P+Q , decreasing = TRUE)

affichagePolynome(soustractionDeDeuxPolynomes(polynomeB = polynomeP, polynomeA = polynomeQ))
print(Q-P , decreasing = TRUE)

affichagePolynome(additionDeDeuxPolynomes(polynomeA = polynomeS, polynomeB = polynomeR))
print(S+R , decreasing = TRUE)

affichagePolynome(soustractionDeDeuxPolynomes(polynomeA = polynomeS, polynomeB = polynomeR))
print(S-R , decreasing = TRUE)

affichagePolynome(produitDeDeuxPolynomes(polynomeA = polynomeP, polynomeB = polynomeR))
print(P*R , decreasing = TRUE)

affichagePolynome(produitDeDeuxPolynomes(polynomeA = polynomeQ, polynomeB = polynomeS))
print(Q*S , decreasing = TRUE)

affichagePolynome(produitDeDeuxPolynomes(polynomeA = polynomeP, polynomeB = polynomeQ))
print(P*Q , decreasing = TRUE)

affichagePolynome(produitDeDeuxPolynomes(polynomeA = polynomeR, polynomeB = polynomeS))
print(R*S , decreasing = TRUE)

