package calculatrice.model;

import calculatrice.util.DivisionParZeroException;

public class SandBox {
	public static void main(String[] args){
		Calculatrice calculatrice = new Calculatrice();
		
		int dividende = 42;
		int diviseur = 2;
		int quotient = 0;
		
		
		try {
			quotient = calculatrice.diviser(dividende, diviseur);
		} catch (DivisionParZeroException e) {
			System.out.println("Division par zéro impossible");
			System.out.println("L'exception capturée est " + e.getMessage());
		}
		System.out.println("Le quotient de " + dividende + " par " + diviseur + " est " + quotient);
		
		
		try {
			quotient = calculatrice.diviser(42, 0);	
			} catch (DivisionParZeroException | ArithmeticException e) {
				System.out.println("Division par zéro impossible");
				System.out.println("L'exception capturée est " + e.getMessage());
		}
		
		try {
			quotient = calculatrice.diviser(42, 0);	
			} catch (Exception e) {
				System.out.println("Division par zéro impossible");
				System.out.println("L'exception capturée est " + e.getMessage());
		}
		
	}

}
