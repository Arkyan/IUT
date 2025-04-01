package canard.model;

import canard.model.cancan.ComportementCancan;
import canard.model.vol.ComportementVol;

public class PrototypeCanard extends Canard {
	
	public PrototypeCanard(String nom, ComportementVol comportementVol, ComportementCancan comportementCancan) {
		super(nom);
		this.comportementVol = comportementVol;
		this.comportementCancan = comportementCancan;
	}	
	
	@Override
	public String afficher() {
		return "Je suis un prototype de canard et je m'appelle " + getNom();
	}

}
