package canard.model;

import canard.model.cancan.CanardMuet;
import canard.model.cancan.ComportementCancan;
import canard.model.vol.ComportementVol;
import canard.model.vol.NePasVoler;

public class Leurre extends Canard {
	
	public Leurre(String nom) {
		super(nom);
		this.comportementVol = new NePasVoler();
		this.comportementCancan = new CanardMuet();
	}
	
	@Override
	public String afficher() {
		return "Je suis un leurre";
	}

	

}
