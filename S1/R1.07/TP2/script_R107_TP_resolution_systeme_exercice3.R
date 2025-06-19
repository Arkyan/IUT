##########################################################################
############################### Exercice 3  ##############################
##########################################################################

##########################################################################
#  Création d'une fonction d'arrondi pour les calculs  en fin de TP ######
##########################################################################
mettreValeurMatriceAZero <- function(matriceA, precision = 1e-10) {
  matriceA[abs(matriceA) < precision] <- 0
  return(matriceA)
}

#' Echelonne une matrice
#'
#' @param matriceA 
#'
#' @return matriceA mais échelonnée
#' @export
#'
#' @examples
echelonneUneMatrice <- function(matriceA){
  compteurLigne <- 1
  compteurColonne <- 1
  
  echangeEncorePossible <- TRUE
  while (echangeEncorePossible & compteurLigne< nrow(matriceA) ){
    matriceA <- mettreValeurMatriceAZero(matriceA)
    # On travaille sur une matrice extraite car on doit travailler sur les lignes en desssous du pivot actuel 
    # et on doit travailler sur les colonnes à droite du pivot . 
    matriceExtraite <- matriceA[compteurLigne : nrow(matriceA),  compteurColonne: ncol(matriceA), drop=FALSE]
    compteurColonneMatriceExtraite <- 1
    while (compteurColonneMatriceExtraite <=ncol(matriceExtraite) && all(matriceExtraite[, compteurColonneMatriceExtraite]==0)) {
      # On cherche les colonnes contenant uniquement des zéros pour déterminer la colonne 
      # qui permettra de faire le pivot
      compteurColonneMatriceExtraite <- compteurColonneMatriceExtraite+1
    }
    compteurColonne <-  compteurColonne+compteurColonneMatriceExtraite-1
    if (compteurColonne<= ncol(matriceA)){
      if (all(matriceA[compteurLigne,]==0)| matriceA[compteurLigne,compteurColonne]==0 ){
        # Si la premiere ligne possible pour faire le pivot ne contient que des zéros alors on échange 
        # avec un ligne qui a au moins un nombre non nul, trouvé par la colonne pivot de tout à l'heure.
        # Si le pivot est nul on échange aussi. 
        matriceA <- rowswap(matriceA,compteurLigne, compteurLigne-1 + which((matriceExtraite[,compteurColonneMatriceExtraite]!=0)==TRUE)[1])
        # maintenant nous sommes certain que le pivot est non nul.
      }else{
      }
      # On met des zéros sous le pivot, ici c'est fait de façon vectorielle.
      matriceA <- rowadd( matriceA, rep(compteurLigne, nrow(matriceA)-compteurLigne), seq(compteurLigne+1, nrow(matriceA)), -1*matriceA[seq(compteurLigne+1, nrow(matriceA)),compteurColonne] / matriceA[compteurLigne,compteurColonne])
    }else{
      # on a dépassé le nombre de colonne donc il n'y a plus de pivot possible. 
      echangeEncorePossible <- FALSE
    }
    compteurLigne <- compteurLigne+1
  }
  # Les rowadd et rowswap ne change pas le mode de la matrice mais rajoute des attributs.
  # Le fait de la retransformer avec as.matrix en matrice va enlever des attributs inutiles. 
  return(as.matrix(matriceA))
}