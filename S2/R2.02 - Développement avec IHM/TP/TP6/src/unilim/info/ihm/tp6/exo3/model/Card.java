package unilim.info.ihm.tp6.exo3.model;

public class Card {
	Integer value;
	
	Integer getValue() {
		return value;
	}
	
	Card(Integer value) {
		if (value < 1 || value > 12) {
			throw new IllegalArgumentException("La valeur de la carte doit être comprise entre 1 et 12");
		}
		this.value = value;
	}
	
	

}
