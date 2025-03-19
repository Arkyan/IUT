package calculatrice;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class CalculatriceTest {

	@Test
	void doitAdditionerDeuxEntiers() {
		Calculatrice calculatrice = new Calculatrice();
		int nombre1 = 5;
		int nombre2 = 3;
		int resultat = calculatrice.additionner(nombre1, nombre2);
		assertEquals(8, resultat);
	}

	@Test
	void doitSoustraireDeuxEntiers() {
		Calculatrice calculatrice = new Calculatrice();
		int nombre1 = 5;
		int nombre2 = 3;
		int resultat = calculatrice.soustraire(nombre1, nombre2);
		assertEquals(2, resultat);
	}
	
	@Test
	void doitMultiplierDeuxEntiers() {
		Calculatrice calculatrice = new Calculatrice();
		int nombre1 = 5;
		int nombre2 = 3;
		int resultat = calculatrice.multiplier(nombre1, nombre2);
		assertEquals(15, resultat);
	}
	
	@Test
	void doitDiviserDeuxEntiers() {
		Calculatrice calculatrice = new Calculatrice();
		int dividende = 42;
		int diviseur = 2;
		int resultat = calculatrice.diviser(dividende, diviseur);
		assertEquals(21, resultat);
	}
	
	@Test
	void doitLeverUneArithmeticExceptionSiDivisionParZéro() {
		Calculatrice calculatrice = new Calculatrice();
		assertThrows(ArithmeticException.class, () -> calculatrice.diviser(42, 0));
	}
	
}
