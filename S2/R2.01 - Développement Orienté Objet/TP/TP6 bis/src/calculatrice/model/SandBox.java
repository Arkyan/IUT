package calculatrice;

public class SandBox {
	public static void main(String[] args) {
		Calculatrice calculatrice = new Calculatrice();
		
		int dividende = 42;
		int diviseur = 2;
		int quotient = calculatrice.diviser(dividende, diviseur);
		System.out.println("Le quotient de " + dividende + " par " + diviseur + " est " + quotient);
		
		
		try {
			quotient = calculatrice.diviser(42, 0);	
			} catch (ArithmeticException e) {
				System.out.println("Division par zéro impossible");
				System.out.println("L'exception capturée est " + e.getMessage());
		}
		
	}

}
