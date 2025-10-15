#ifndef ARBREBINAIRE_H
#define ARBREBINAIRE_H

#include <iostream>
#include <stdexcept>

template <typename T>
class ArbreBinaire {
private:
    struct Noeud {
        T valeur;
        Noeud* gauche;
        Noeud* droite;

        Noeud(const T& val, Noeud* g = nullptr, Noeud* d = nullptr)
            : valeur(val), gauche(g), droite(d) {}
    };

    Noeud* racine;

public:
    // Constructeur d'arbre vide
    ArbreBinaire() : racine(nullptr) {}

    // Constructeur enracine(e, a1, a2)
    ArbreBinaire(const T& e, const ArbreBinaire<T>& a1, const ArbreBinaire<T>& a2) {
        racine = new Noeud(e, copier(a1.racine), copier(a2.racine));
    }

    // Destructeur
    ~ArbreBinaire() { detruire(racine); }

    // Vérifie si l'arbre est vide
    bool estVide() const {
        return racine == nullptr;
    }

    // Retourne la valeur de la racine
    T racineValeur() const {
        if (estVide()) throw std::runtime_error("Arbre vide !");
        return racine->valeur;
    }

    // Retourne le sous-arbre gauche
    ArbreBinaire<T> ag() const {
        if (estVide()) throw std::runtime_error("Arbre vide !");
        ArbreBinaire<T> g;
        g.racine = copier(racine->gauche);
        return g;
    }

    // Retourne le sous-arbre droit
    ArbreBinaire<T> ad() const {
        if (estVide()) throw std::runtime_error("Arbre vide !");
        ArbreBinaire<T> d;
        d.racine = copier(racine->droite);
        return d;
    }

    // Parcours préfixe
    void parcoursPrefixe() const {
        parcoursPrefixe(racine);
        std::cout << std::endl;
    }

private:
    static Noeud* copier(Noeud* n) {
        if (!n) return nullptr;
        return new Noeud(n->valeur, copier(n->gauche), copier(n->droite));
    }

    static void detruire(Noeud* n) {
        if (!n) return;
        detruire(n->gauche);
        detruire(n->droite);
        delete n;
    }

    static void parcoursPrefixe(Noeud* n) {
        if (!n) return;
        std::cout << n->valeur << " ";
        parcoursPrefixe(n->gauche);
        parcoursPrefixe(n->droite);
    }
};

#endif
