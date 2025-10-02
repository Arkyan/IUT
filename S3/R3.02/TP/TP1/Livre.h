//
// Created by didry on 02/10/2025.
//

#ifndef TP_LIVRE_H
#define TP_LIVRE_H

#include "Media.h"

class Livre : public Media {
    int nbPages;
public:
    Livre(string t, string a, int y, int p) : Media(t,a,y), nbPages(p) {}
    void afficher() const override {
        Media::afficher();
        cout << ", Pages: " << nbPages << endl;
    }
};

#endif

