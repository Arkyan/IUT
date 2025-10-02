//
// Created by didry on 02/10/2025.
//

#ifndef TP_MEDIA_H
#define TP_MEDIA_H
#include <iostream>
#include <string>

using namespace std;

class Media {
protected:
    string titre;
    string auteur;
    int annee;
public:
    Media(string t, string a, int y) : titre(t), auteur(a), annee(y) {}
    virtual ~Media() {}

    string getTitre() const { return titre; }

    virtual void afficher() const {
        cout << "Titre: " << titre << ", Auteur: " << auteur << ", Annee: " << annee;
    }
};

#endif