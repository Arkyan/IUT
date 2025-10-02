//
// Created by didry on 02/10/2025.
//

#ifndef TP_VINYLE_H
#define TP_VINYLE_H
#include "Media.h"

class Vinyle : public Media {
    int nbTitres;
public:
    Vinyle(string t, string a, int y, int n) : Media(t,a,y), nbTitres(n) {}
    void afficher() const override {
        Media::afficher();
        cout << ", Titres (Vinyle): " << nbTitres << endl;
    }
};

#endif


