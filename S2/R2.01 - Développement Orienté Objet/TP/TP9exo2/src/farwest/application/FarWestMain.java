package farwest.application;
import farwest.model.personnagefarwest.*;
import farwest.model.*;


import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class FarWestMain {

	private static final String LIGNE = "---------------------------------------------------";

	public static void main(String[] args) {

		Cheval jollyJumper = new Cheval("Jolly Jumper", "appaloosa");
		Heros luckyLuke = new Heros("Lucky", "Luke", "cow-boy", jollyJumper);

		Bandit joeDalton = new Bandit("Joe", "Dalton", 140);
		Bandit averellDalton = new Bandit("Averell", "Dalton", 213);
		Bandit williamDalton = new Bandit("William", "Dalton", 168);
		Bandit jackDalton = new Bandit("Jack", "Dalton", 193);

		Bourgeois zacharieMartins = new Bourgeois("Zacharie", "Martins", "inventeur");
		Enfant phineas = new Enfant("Phineas", 10);

		System.out.println(LIGNE);
		System.out.println("Les personnages de la caravanne sont : ");

		Collection<PersonnageFarWest> personnagesDansLaCaravane = Arrays.asList(luckyLuke, joeDalton, averellDalton,
				zacharieMartins, phineas);

		for (PersonnageFarWest personnage : personnagesDansLaCaravane) {
			System.out.println(personnage.decrire());
		}

		System.out.println(LIGNE);
		System.out.println("Les personnages capable de tirer au pistolet sont : ");

		Collection<EtreCapableDeTirerAvecUneArmeAFeu> personnagesCapableDeTirerAuPistolet = Arrays.asList(luckyLuke,
				joeDalton, averellDalton, zacharieMartins);

		for (EtreCapableDeTirerAvecUneArmeAFeu tireurAuPistolet : personnagesCapableDeTirerAuPistolet) {
			afficherPrenomEtNom((PersonnageFarWest) tireurAuPistolet);
			tireurAuPistolet.tirerAuPistolet();
		}
		
		class ComparateurTailleCroissante implements Comparator<Bandit> {
			@Override
			public int compare(Bandit bandit1, Bandit bandit2) {
				return bandit1.taille().compareTo(bandit2.taille());
			}
		}
		
		class ComparateurTailleDecroissante implements Comparator<Bandit> {
			@Override
			public int compare(Bandit bandit1, Bandit bandit2) {
				return bandit2.taille().compareTo(bandit1.taille());
			}
		}
		
		System.out.println(LIGNE);
		
		System.out.println("Les bandits triés par taille sont : ");
		List<Bandit> bandits = Arrays.asList(joeDalton, averellDalton, williamDalton, jackDalton);
		Collections.sort(bandits, new ComparateurTailleCroissante());
		
		for (Bandit bandit : bandits) {
			System.out.println(bandit.decrire());
		}
		
		System.out.println(LIGNE);
		
		System.out.println("Les bandits triés par taille décroissante sont : ");
		Collections.sort(bandits, new ComparateurTailleDecroissante());
		for (Bandit bandit : bandits) {
			System.out.println(bandit.decrire());
		}

	}

	private static void afficherPrenomEtNom(PersonnageFarWest personnage) {
		System.out.print(personnage.prenom() + " " + personnage.nom() + " ! ");
	}
}