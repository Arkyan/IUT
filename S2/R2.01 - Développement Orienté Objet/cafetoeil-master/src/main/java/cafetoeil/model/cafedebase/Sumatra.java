package cafetoeil.model.cafedebase;

import cafetoeil.model.Boisson;

public class Sumatra implements Boisson {
	@Override
	public String description() {
		return "Café Sumatra";
	}

	@Override
	public double prix() {
		return 0.99;
	}

}
