//
// Created by didry on 02/10/2025.
//

#ifndef TP_CD_H
#define TP_CD_H
#include "Media.h"

class CD : public Media {
    int nbTitres;
public:
    CD(string t, string a, int y, int n) : Media(t,a,y), nbTitres(n) {}
    void afficher() const override {
        Media::afficher();
        cout << ", Titres: " << nbTitres << endl;
    }
};

#endif


