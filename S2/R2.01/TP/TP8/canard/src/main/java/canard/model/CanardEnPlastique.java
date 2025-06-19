package canard.model;

import canard.model.cancan.Coincoin;
import canard.model.cancan.ComportementCancan;
import canard.model.vol.ComportementVol;
import canard.model.vol.NePasVoler;

public class CanardEnPlastique extends Canard {
	
	public CanardEnPlastique(String nom) {
		super(nom);
		this.comportementVol = new NePasVoler();
		this.comportementCancan = new Coincoin();
	}
	

	@Override
	public String afficher() {
		return "Je suis un canard en plastique";
	}
	
	


}
