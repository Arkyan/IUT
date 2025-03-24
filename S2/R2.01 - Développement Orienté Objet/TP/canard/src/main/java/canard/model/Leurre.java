package canard.model;

public class Leurre extends Canard {
	
	public Leurre(String nom) {
		super(nom);
	}
	
	@Override
	public String afficher() {
		return "Je suis un leurre et je m'appelle " + getNom();
	}

	

}
