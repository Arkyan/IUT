package canard.model;
import canard.model.cancan.*;
import canard.model.vol.*;

public abstract class Canard{
	private final String nom;
	protected ComportementVol comportementVol;
	protected ComportementCancan comportementCancan;
	
	public Canard(String nom) {
		this.nom = nom;
	}
	
	public String getNom() {
		return nom;
	}
	
	public String nager() {
		return "Tous les canards flottent, même les leurres!";
	}
	
	public String afficher() {
		return "Je suis un vrai canard";
	}

	public String effectuerVol() {
		return comportementVol.voler();
	}
	
	public String effectuerCancan() {
		return comportementCancan.cancaner();
	}
	
	public void changerComportementVol(ComportementVol comportementVol) {
		this.comportementVol = comportementVol;
	}
	
	public void changerComportementCancan(ComportementCancan comportementCancan) {
		this.comportementCancan = comportementCancan;
	}

}
