package unilim.info.ihm.tp3.model;

import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;

public class AchatCondiment {
	private String nom;
	private Color couleur;
	private ImageView image;
	private String prix;
	private String quantité;
	
	public AchatCondiment(String nom, Color couleur, ImageView image, String prix, String quantité) {
		this.nom = nom;
		this.couleur = couleur;
		this.image = image;
		this.prix = prix;
		this.quantité = quantité;
	}

}
