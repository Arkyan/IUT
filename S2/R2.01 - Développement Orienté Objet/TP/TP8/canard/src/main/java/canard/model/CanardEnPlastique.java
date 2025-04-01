package canard.model;

import canard.model.cancan.ComportementCancan;
import canard.model.vol.ComportementVol;

public class CanardEnPlastique extends Canard {
	
	public CanardEnPlastique(String nom,ComportementVol comportementVol, ComportementCancan comportementCancan) {
		super(nom);
		this.comportementVol = comportementVol;
		this.comportementCancan = comportementCancan;
	}
	

	@Override
	public String afficher() {
		return "Je suis un canard en plastique et je m'appelle " + getNom();
	}
	
	


}
