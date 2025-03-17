package farwest.model.personnagefarwest;
import farwest.model.EtreCapableDeTirerAvecUneArmeAFeu;

public class Bourgeois extends PersonnageFarWest implements EtreCapableDeTirerAvecUneArmeAFeu {
	private String profession;
	
	public Bourgeois(String nom, String prenom, String profession) {
		super(nom, prenom);
		this.profession = profession;
	}
	
	public String decrire() {
		return super.decrire() + " et je suis " + this.profession;
	}
	
	public void faireDesAffaires() {
		// TODO
	}
	
	@Override
	public void tirerAuPistolet() {
		System.out.println(" Je tire très mal au pistolet : ...... Pan....");
	}
	

}
