package canard.model;

import canard.model.cancan.ComportementCancan;
import canard.model.vol.ComportementVol;

public class Mandarin extends Canard {
	
	public Mandarin(String nom, ComportementVol comportementVol, ComportementCancan comportementCancan) {
		super(nom);
		this.comportementVol = comportementVol;
		this.comportementCancan = comportementCancan;
	}
	
	@Override
	public String afficher() {
		return "Je suis un mandarin et je m'appelle " + getNom();
	}
}
