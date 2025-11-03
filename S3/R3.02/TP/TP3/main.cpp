#include <iostream>
#include "ArbreBinaire.h"

int main() {
    ArbreBinaire<int> aVide;

    // Sous-arbre droit de 8 : 7 et 1
    ArbreBinaire<int> aSousD(8,
        ArbreBinaire<int>(7, aVide, aVide),
        ArbreBinaire<int>(1, aVide, aVide));

    // Sous-arbre gauche de 3 : 5 seul
    ArbreBinaire<int> aSousG(5, aVide, aVide);

    // Arbre principal : racine = 3
    ArbreBinaire<int> arbre(3, aSousG, aSousD);

    std::cout << "Racine : " << arbre.racineValeur() << std::endl;
    std::cout << "Sous-arbre gauche : " << arbre.ag().racineValeur() << std::endl;
    std::cout << "Sous-arbre droit : " << arbre.ad().racineValeur() << std::endl;

    std::cout << "Parcours prefixe : ";
    arbre.parcoursPrefixe(); // Résultat attendu : 3 5 8 7 1

    return 0;
}
