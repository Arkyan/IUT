package canard.model;

public class CanardEnPlastique extends Canard {
	
	public CanardEnPlastique(String nom) {
		super(nom);
	}
	

	@Override
	public String afficher() {
		return "Je suis un canard en plastique et je m'appelle " + getNom();
	}


}
