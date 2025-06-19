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


