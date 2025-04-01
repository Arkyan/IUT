package canard.model;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import canard.model.cancan.*;
import canard.model.vol.*;

class CanardTest {
	private static final String NAGER = "Tous les canards flottent, même les leurres!";

	private static final String VOLER = "Je vole !";
	private static final String NE_PAS_VOLER = "Je ne sais pas voler";
	private static final String REACTEUR = "Je vole avec un réacteur !";

	private static final String CANCAN = "Can-can";
	private static final String COINCOIN = "Coin-coin";
	private static final String SILENCE = "...Silence...";

	Canard colvert;
	Canard leurre;
	Canard mandarin;
	Canard canardPlastique;
	Canard prototype;

	@BeforeEach
	private void extracted() {
		colvert = new Colvert("Piero", new VolerAvecDesAiles(), new Cancan());
		leurre = new Leurre("Danny", new NePasVoler(), new CanardMuet());
		mandarin = new Mandarin("Oshidori", new VolerAvecDesAiles(), new Cancan());
		canardPlastique = new CanardEnPlastique("Rubber", new NePasVoler(), new Coincoin());
		prototype = new PrototypeCanard("Prototype", new VolerAvecDesAiles(), new Cancan());
	}

	@Test
	public void test_effectuerVol() {
		String texteVolColvert = colvert.effectuerVol();
		assertEquals(VOLER, texteVolColvert);

		// on peut inliner les assert
		// car ici le code de test est simple à lire
		assertEquals(VOLER, mandarin.effectuerVol());

		assertEquals(NE_PAS_VOLER, leurre.effectuerVol());
		assertEquals(NE_PAS_VOLER, canardPlastique.effectuerVol());
		assertEquals(REACTEUR, prototype.effectuerVol());
	}

	@Test
	public void test_effectuerCancan() {

		assertEquals(CANCAN, colvert.effectuerCancan());
		assertEquals(CANCAN, mandarin.effectuerCancan());

		assertEquals(SILENCE, leurre.effectuerCancan());
		assertEquals(COINCOIN, canardPlastique.effectuerCancan());
	}

	@Test
	public void test_nager() {

		assertEquals(NAGER, colvert.nager());
		assertEquals(NAGER, mandarin.nager());

		assertEquals(NAGER, leurre.nager());
		assertEquals(NAGER, canardPlastique.nager());
	}

	@Test
	public void test_presentation_nom_et_afficher() {
		assertEquals("Piero", colvert.getNom());
		assertEquals("Je suis un vrai colvert", colvert.afficher());

		assertEquals("Oshidori", mandarin.getNom());
		assertEquals("Je suis un vrai mandarin", mandarin.afficher());

		assertEquals("Danny", leurre.getNom());
		assertEquals("Je suis un leurre", leurre.afficher());

		assertEquals("Rubber", canardPlastique.getNom());
		assertEquals("Je suis un canard en plastique", canardPlastique.afficher());
		
		assertEquals("Prototype", prototype.getNom());
		assertEquals("Je suis un prototype de canard", prototype.afficher());
	}

}