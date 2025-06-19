package calculatrice.model;

import calculatrice.util.DivisionParZeroException;

public class Calculatrice {
	
	public int additionner(int a, int b) {
		return a + b;
	}

	public int soustraire(int a, int b) {
		return a - b;
	}

	public int multiplier(int a, int b) {
		return a * b;
	}

	public int diviser(int a, int b) throws DivisionParZeroException {
		if (b == 0) {
			throw new DivisionParZeroException("Division par zéro impossible");
		}
		return a / b;
	}
	
}
