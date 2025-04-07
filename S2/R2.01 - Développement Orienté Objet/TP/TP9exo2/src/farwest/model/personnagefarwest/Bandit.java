package farwest.model.personnagefarwest;
import farwest.model.EtreCapableDeTirerAvecUneArmeAFeu;

public class Bandit extends PersonnageFarWest implements EtreCapableDeTirerAvecUneArmeAFeu, Comparable<PersonnageFarWest>  {
	private Integer taille;
	private Boolean estEnPrison;
	
	public Bandit(String prenom, String nom, Integer taille) {
		super(prenom, nom);
		this.taille = taille;
		this.estEnPrison = false;
	}
	
    public String decrire() {
        if (this.estEnPrison){
            return this.prenom + " " + this.nom + "!" + "Je mesure " + this.taille + " cm et je suis en prison";
        } else {
            return this.prenom + " " + this.nom + "!" + "Je mesure " + this.taille + " cm et je suis libre";
        }
    }
	
    	public Integer taille() {
    				return this.taille;
    	}
    
	public void faireUnBraquage(){
		// TODO
	}
	
	public void mettreEnPrison(){
		this.estEnPrison = true;
	}
	
	public void libererDePrison(){
		this.estEnPrison = false;
	}
	
	public void tirerAuPistolet() {
		System.out.println(" Je tire très bien au pistolet : .....Pan....Pan....Pan");
	}
	
	@Override
	public int compareTo(PersonnageFarWest autrePersonnage) {
		return this.nom.compareTo(autrePersonnage.nom);
	}

}
