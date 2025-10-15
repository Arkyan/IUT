#include <iostream>
#include "ArbreBinaire.h"

int main() {
    ArbreBinaire<int> aVide;

    ArbreBinaire<int> aG(2,
        ArbreBinaire<int>(4, aVide, aVide),
        ArbreBinaire<int>(5, aVide, aVide));

    ArbreBinaire<int> aD(3,
        ArbreBinaire<int>(6, aVide, aVide),
        ArbreBinaire<int>(7, aVide, aVide));

    ArbreBinaire<int> arbre(1, aG, aD);

    std::cout << "Racine : " << arbre.racineValeur() << std::endl;
    std::cout << "Sous-arbre gauche : " << arbre.ag().racineValeur() << std::endl;
    std::cout << "Sous-arbre droit : " << arbre.ad().racineValeur() << std::endl;

    std::cout << "Parcours prefixe : ";
    arbre.parcoursPrefixe(); // Attendu : 1 2 4 5 3 6 7

    return 0;
}
