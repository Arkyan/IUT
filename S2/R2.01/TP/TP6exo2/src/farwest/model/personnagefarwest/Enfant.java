package farwest.model.personnagefarwest;

public class Enfant extends PersonnageFarWest {
	private Integer age;
	
	public Enfant(String prenom, Integer age) {
		super(prenom);
		this.age = age;
	}
	
	
	
	public String decrire() {
		return super.decrire() + " et j'ai " + this.age + " ans";
	}
	
	public void faireDesBetises(){
		// TODO
	}
}
