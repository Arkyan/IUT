package farwest.model.personnagefarwest;

public abstract class PersonnageFarWest {
	protected String nom;
	protected String prenom;
	
	public PersonnageFarWest(String nom, String prenom) {
		this.nom = nom;
		this.prenom = prenom;
		
	}
	
	public PersonnageFarWest(String nom) {
		this.nom = nom;
	}
	
	public String decrire() {
		return "Je suis " + this.nom + " " + this.prenom;
	}
	
	public String nom() {
		return this.nom;
	}
	
	public String prenom() {
		return this.prenom;
	}
}
