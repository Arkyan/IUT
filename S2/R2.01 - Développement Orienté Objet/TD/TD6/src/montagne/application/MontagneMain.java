package montagne.application;

import montagne.ihm.Console;
import montagne.metier.Sommet;
import montagne.metier.ChaineDeMontagne;

import java.util.ArrayList;
import java.util.List;

public class MontagneMain {
    public static void main(String[] args) {
        Console.titre("Mes Sommets");

        // Création de la liste de sommets
        List<Sommet> sommets = new ArrayList<>();

        // Ajout des sommets à la liste
        sommets.add(new Sommet("Mont Blanc", 4809, ChaineDeMontagne.MONTBLANC));
        sommets.add(new Sommet("Aiguille des Grands Montets", 3295, ChaineDeMontagne.MONTBLANC));
        sommets.add(new Sommet("La Rhune", 905, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic du Midi", 2877, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic d'Aneto", 3404, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic du Canigou", 2785, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Puy de Sancy", 1579, ChaineDeMontagne.MASSIF_CENTRAL));
        sommets.add(new Sommet("Puy de Dôme", 1465, ChaineDeMontagne.MASSIF_CENTRAL));
        sommets.add(new Sommet("Le Grand Ballon", 1424, ChaineDeMontagne.VOSGES));

        // Affichage des descriptions des sommets
        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }

        Console.message("..");
        Console.message("..");

        // Tri des sommets par altitude
        Console.titre("Sommets triés par altitude décroissante");
        sommets.sort(null);
        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }
    }
}
