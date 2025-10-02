//
// Created by didry on 02/10/2025.
//

#ifndef TP_BLURAY_H
#define TP_BLURAY_H
#include "Media.h"

class BluRay : public Media {
    int duree;
public:
    BluRay(string t, string a, int y, int d) : Media(t,a,y), duree(d) {}
    void afficher() const override {
        Media::afficher();
        cout << ", Duree (BluRay): " << duree << " min" << endl;
    }
};

#endif

