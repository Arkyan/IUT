//
// Created by didry on 02/10/2025.
//

#ifndef TP_DVD_H
#define TP_DVD_H

#include "Media.h"

class DVD : public Media {
    int duree;
public:
    DVD(string t, string a, int y, int d) : Media(t,a,y), duree(d) {}
    void afficher() const override {
        Media::afficher();
        cout << ", Duree: " << duree << " min" << endl;
    }
};

#endif


