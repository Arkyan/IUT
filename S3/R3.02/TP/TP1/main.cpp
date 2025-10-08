//
// Created by didry on 02/10/2025.
//
#include <windows.h>
#include <iostream>
#include <vector>
#include <memory>
#include "Livre.h"
#include "CD.h"
#include "DVD.h"
#include "BluRay.h"
#include "Vinyle.h"

using namespace std;

void afficherMedias(const vector<shared_ptr<Media>>& medias) {
    if (medias.empty()) {
        cout << "La médiathèque est vide." << endl;
        return;
    }
    for (size_t i=0; i<medias.size(); i++) {
        cout << i+1 << ". ";
        medias[i]->afficher();
    }
}

void ajouterMedia(vector<shared_ptr<Media>>& medias) {
    int choix;
    cout << "Type de média a ajouter :\n";
    cout << "1. Livre\n2. CD\n3. DVD\n4. BluRay\n5. Vinyle\n";
    cin >> choix;
    cin.ignore();

    string titre, auteur;
    int annee;
    cout << "Titre: ";
    getline(cin, titre);
    cout << "Auteur: ";
    getline(cin, auteur);
    cout << "Année: ";
    cin >> annee;

    switch(choix) {
        case 1: {
            int pages;
            cout << "Pages: ";
            cin >> pages;
            medias.push_back(make_shared<Livre>(titre, auteur, annee, pages));
            break;
        }
        case 2: {
            int titres;
            cout << "Titres: ";
            cin >> titres;
            medias.push_back(make_shared<CD>(titre, auteur, annee, titres));
            break;
        }
        case 3: {
            int duree;
            cout << "Durée (min): ";
            cin >> duree;
            medias.push_back(make_shared<DVD>(titre, auteur, annee, duree));
            break;
        }
        case 4: {
            int duree;
            cout << "Durée (min): ";
            cin >> duree;
            medias.push_back(make_shared<BluRay>(titre, auteur, annee, duree));
            break;
        }
        case 5: {
            int titres;
            cout << "Titres: ";
            cin >> titres;
            medias.push_back(make_shared<Vinyle>(titre, auteur, annee, titres));
            break;
        }
        default:
            cout << "Choix invalide." << endl;
    }
}

void supprimerMedia(vector<shared_ptr<Media>>& medias) {
    afficherMedias(medias);
    if(medias.empty()) return;
    int index;
    cout << "Numéro de l'élément a supprimer: ";
    cin >> index;
    if(index > 0 && index <= (int)medias.size()) {
        medias.erase(medias.begin() + index - 1);
        cout << "Média supprime." << endl;
    } else {
        cout << "Index invalide." << endl;
    }
}

void rechercherMedia(const vector<shared_ptr<Media>>& medias) {
    cin.ignore();
    string recherche;
    cout << "Titre a rechercher: ";
    getline(cin, recherche);
    bool trouve = false;
    for (const auto& m : medias) {
        if(m->getTitre() == recherche) {
            m->afficher();
            trouve = true;
        }
    }
    if(!trouve) cout << "Aucun média trouve." << endl;
}

int main() {
    SetConsoleOutputCP(CP_UTF8);
    vector<shared_ptr<Media>> medias;
    int choix;
    do {
        cout << "\n--- MENU ---\n";
        cout << "1. Afficher\n";
        cout << "2. Ajouter\n";
        cout << "3. Supprimer\n";
        cout << "4. Rechercher\n";
        cout << "5. Quitter\n";
        cout << "Choix: ";
        cin >> choix;

        switch(choix) {
            case 1: afficherMedias(medias); break;
            case 2: ajouterMedia(medias); break;
            case 3: supprimerMedia(medias); break;
            case 4: rechercherMedia(medias); break;
            case 5: cout << "Au revoir !" << endl; break;
            default: cout << "Choix invalide." << endl;
        }
    } while(choix != 5);

    return 0;
}