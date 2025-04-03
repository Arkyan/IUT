package canard.application;

import canard.model.*;
import canard.model.vol.PropulsionAReaction;


public class Client {
	public static void main(String[] args) {
		Colvert colvert = new Colvert("Latice");
		System.out.println(colvert.afficher());
		System.out.println(colvert.nager());
		System.out.println(colvert.effectuerCancan());
		System.out.println(colvert.effectuerVol());
		
		PrototypeCanard prototype = new PrototypeCanard("Prototype");
		System.out.println(prototype.afficher());
		System.out.println(prototype.effectuerVol());
		prototype.changerComportementVol(new PropulsionAReaction());
		System.out.println(prototype.effectuerVol());
	}

}
