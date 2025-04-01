package canard.application;

import java.util.ArrayList;
import java.util.List;

import canard.model.*;
import canard.model.cancan.*;
import canard.model.vol.NePasVoler;
import canard.model.vol.VolerAvecDesAiles;

public class Simulateur {

	private static final String LIGNE = "-----------------";

	public static void main(String[] args) {

		List<Canard> canards = mettreDesCanardsDansMonSimulateur();

		faireAfficherEtNager(canards);

	}

	private static List<Canard> mettreDesCanardsDansMonSimulateur() {
		List<Canard> canards = new ArrayList<>();
		canards.add(new Colvert("Piero", new VolerAvecDesAiles(), new Cancan()));
		canards.add(new Leurre("Danny", new NePasVoler(), new CanardMuet()));
		canards.add(new Mandarin("Oshidori", new VolerAvecDesAiles(), new Cancan()));
		canards.add(new CanardEnPlastique("Rubber", new NePasVoler(), new Coincoin()));
		canards.add(new PrototypeCanard("Prototype", new VolerAvecDesAiles(), new Cancan()));
		return canards;
	}

	private static void faireAfficherEtNager(List<Canard> canards) {
		System.out.println(LIGNE);
		System.out.println("Afficher et Nager");
		System.out.println(LIGNE);

		for (Canard canard : canards) {
			System.out.println(canard.getNom() + " : " + canard.afficher());
			System.out.println(canard.nager());
			System.out.println(canard.effectuerVol());
			System.out.println(canard.effectuerCancan());
		}
	}
}