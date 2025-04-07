package montagne.application;

import montagne.ihm.Console;
import montagne.metier.Sommet;
import montagne.metier.ChaineDeMontagne;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class MontagneMain {
    public static void main(String[] args) {
        Console.titre("Mes Sommets");

        List<Sommet> sommets = new ArrayList<>();

        sommets.add(new Sommet("Mont Blanc", 4809, ChaineDeMontagne.MONTBLANC));
        sommets.add(new Sommet("Aiguille des Grands Montets", 3295, ChaineDeMontagne.MONTBLANC));
        sommets.add(new Sommet("La Rhune", 905, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic du Midi", 2877, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic d'Aneto", 3404, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Pic du Canigou", 2785, ChaineDeMontagne.PYRENEES));
        sommets.add(new Sommet("Puy de Sancy", 1579, ChaineDeMontagne.MASSIF_CENTRAL));
        sommets.add(new Sommet("Puy de Dôme", 1465, ChaineDeMontagne.MASSIF_CENTRAL));
        sommets.add(new Sommet("Le Grand Ballon", 1424, ChaineDeMontagne.VOSGES));

        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }

        Console.message("..");
        Console.message("..");

        // Tri des sommets par altitude
        Console.titre("Sommets triés par altitude décroissante avec sort");
        Collections.sort(sommets);
        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }

        class ComparateurAltitude implements Comparator<Sommet> {
            @Override
            public int compare(Sommet sommet1, Sommet sommet2) {
                return sommet1.altitude().compareTo(sommet2.altitude());
            }
        }

        class ComparateurNom implements Comparator<Sommet> {
            @Override
            public int compare(Sommet sommet1, Sommet sommet2) {
                return sommet1.nom().compareTo(sommet2.nom());
            }
        }
        
        class ComparateurChaine implements Comparator<Sommet> {
			@Override
			public int compare(Sommet sommet1, Sommet sommet2) {
				return sommet1.chaine().getNom().compareTo(sommet2.chaine().getNom());
			}
		}
        
        class ComparateurChaineAltitudeDécroissante implements Comparator<Sommet> {
            @Override
            public int compare(Sommet sommet1, Sommet sommet2) {
                int cmp = sommet1.chaine().getNom().compareTo(sommet2.chaine().getNom());

                if (cmp == 0) {
                    return sommet2.altitude().compareTo(sommet1.altitude());
                }
                return cmp;
            }
        }


        
        Console.message("..");
        Console.message("..");

        Console.titre("Sommets triés par altitude avec comparator");
        Collections.sort(sommets, new ComparateurAltitude());
        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }

        Console.message("..");
        Console.message("..");

        Console.titre("Sommets triés par nom avec comparator");
        Collections.sort(sommets, new ComparateurNom());
        for (Sommet sommet : sommets) {
            Console.message(sommet.description());
        }
        
        Console.message("..");
        Console.message("..");
        
        Console.titre("Sommets triés par chaine avec comparator");
        Collections.sort(sommets, new ComparateurChaine());
        for (Sommet sommet : sommets) {
			Console.message(sommet.description());
		}
        
        Console.message("..");
		Console.message("..");
		
		Console.titre("Sommets triés par chaine et altitude décroissance avec comparator");
		Collections.sort(sommets, new ComparateurChaineAltitudeDécroissante());
		for (Sommet sommet : sommets) {
			Console.message(sommet.description());
		}
    }
}
