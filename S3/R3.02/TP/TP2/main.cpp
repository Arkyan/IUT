//
// Created by didry on 08/10/2025.
//
#include <iostream>
#include <stdexcept>
#include <windows.h>

class LinkedList {
private:
    struct Node {
        int valeur;
        Node* suivant;
        Node(int v, Node* s = nullptr) : valeur(v), suivant(s) {}
    };

    Node* head;
    Node* tail;
    size_t taille;

    // helper: get pointer to node at position (0-based). throws if OOB
    Node* getNodeAt(size_t position) const {
        if (position >= taille) throw std::out_of_range("position hors limites");
        Node* cur = head;
        for (size_t i = 0; i < position; ++i) cur = cur->suivant;
        return cur;
    }

public:
    // constructeur
    LinkedList() : head(nullptr), tail(nullptr), taille(0) {}

    // destructeur : libère tous les noeuds
    ~LinkedList() { vide(); }

    // interdit la copie implicite pour éviter problèmes (optionnel)
    LinkedList(const LinkedList&) = delete;
    LinkedList& operator=(const LinkedList&) = delete;

    // ajoute en tête
    void adjtete(int valeur) {
        Node* n = new Node(valeur, head);
        head = n;
        if (tail == nullptr) tail = head; // si la liste était vide
        ++taille;
    }

    // supprime la tête (si vide -> exception)
    void suptete() {
        if (est_vide()) throw std::underflow_error("suppression sur liste vide");
        Node* old = head;
        head = head->suivant;
        delete old;
        --taille;
        if (taille == 0) tail = nullptr;
    }

    // ajoute en queue
    void adjqueue(int valeur) {
        Node* n = new Node(valeur, nullptr);
        if (est_vide()) {
            head = tail = n;
        } else {
            tail->suivant = n;
            tail = n;
        }
        ++taille;
    }

    // supprime en queue (si vide -> exception)
    void supqueue() {
        if (est_vide()) throw std::underflow_error("suppression sur liste vide");
        if (tail == head) { // 1 élément
            delete head;
            head = tail = nullptr;
            taille = 0;
            return;
        }
        // parcourir pour trouver l'avant-dernier
        Node* cur = head;
        while (cur->suivant != tail) cur = cur->suivant;
        delete tail;
        tail = cur;
        tail->suivant = nullptr;
        --taille;
    }

    // longueur
    int longueur() const { return static_cast<int>(taille); }

    // retourne l'élément en position (0-based). lance exception si OOB
    int element(int position) const {
        if (position < 0) throw std::out_of_range("position négative");
        Node* n = getNodeAt(static_cast<size_t>(position));
        return n->valeur;
    }

    // insère valeur en position (0-based). si position == taille -> ajoute en queue.
    // si position == 0 -> adjtete
    void adjpos(int valeur, int position) {
        if (position < 0) throw std::out_of_range("position négative");
        size_t pos = static_cast<size_t>(position);
        if (pos == 0) { adjtete(valeur); return; }
        if (pos > taille) throw std::out_of_range("position hors limites");
        if (pos == taille) { adjqueue(valeur); return; }

        Node* prev = getNodeAt(pos - 1);
        Node* n = new Node(valeur, prev->suivant);
        prev->suivant = n;
        ++taille;
    }

    // supprime élément à la position (0-based)
    void suppos(int position) {
        if (position < 0) throw std::out_of_range("position négative");
        if (est_vide()) throw std::underflow_error("suppression sur liste vide");
        size_t pos = static_cast<size_t>(position);
        if (pos >= taille) throw std::out_of_range("position hors limites");

        if (pos == 0) { suptete(); return; }
        Node* prev = getNodeAt(pos - 1);
        Node* target = prev->suivant;
        prev->suivant = target->suivant;
        if (target == tail) tail = prev;
        delete target;
        --taille;
    }

    // vide la liste
    void vide() {
        Node* cur = head;
        while (cur) {
            Node* next = cur->suivant;
            delete cur;
            cur = next;
        }
        head = tail = nullptr;
        taille = 0;
    }

    // est_vide
    bool est_vide() const { return taille == 0; }

    // affiche (format simple)
    void affiche() const {
        std::cout << "[";
        Node* cur = head;
        while (cur) {
            std::cout << cur->valeur;
            if (cur->suivant) std::cout << ", ";
            cur = cur->suivant;
        }
        std::cout << "] (taille=" << taille << ")\n";
    }
};

// Exemple d'utilisation / tests rapides
int main() {
    SetConsoleOutputCP(CP_UTF8);
    LinkedList L;
    std::cout << "Liste initiale : "; L.affiche();

    L.adjtete(3); // [3]
    L.adjtete(1); // [1,3]
    L.adjqueue(5); // [1,3,5]
    L.adjpos(2, 1); // insère 2 en position 1 -> [1,2,3,5]
    std::cout << "Après insertions : "; L.affiche();

    std::cout << "élément(2) = " << L.element(2) << "\n"; // devrait être 3
    std::cout << "longueur = " << L.longueur() << "\n";

    L.suppos(1); // supprime position 1 -> [1,3,5]
    std::cout << "Après suppos(1) : "; L.affiche();

    L.suptete(); // supprime tête -> [3,5]
    std::cout << "Après suptete : "; L.affiche();

    L.supqueue(); // supprime queue -> [3]
    std::cout << "Après supqueue : "; L.affiche();

    L.vide();
    std::cout << "Après vide() : "; L.affiche();
    return 0;
}
