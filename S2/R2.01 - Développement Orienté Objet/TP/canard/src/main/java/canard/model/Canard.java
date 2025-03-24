package canard.model;

public class Canard {
	private final String nom;
	
	public Canard(String nom) {
		this.nom = nom;
	}
	
	public String getNom() {
		return nom;
	}
	
	public String nager() {
		return "Tous les canards flottent, même les leurres !";
	}
	
	public String afficher() {
		return "Je suis un canard et je m'appelle " + nom;
	}

}
