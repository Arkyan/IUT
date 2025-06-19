package canard.model;

import canard.model.cancan.CanardMuet;
import canard.model.vol.NePasVoler;

public class PrototypeCanard extends Canard {
	
	public PrototypeCanard(String nom) {
		super(nom);
		this.comportementVol = new NePasVoler();
		this.comportementCancan = new CanardMuet();
	}	
	
	@Override
	public String afficher() {
		return "Je suis un prototype de canard";
	}

}
