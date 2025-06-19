package unilim.info.ihm.tp6.exo3.tools;

import javafx.scene.image.Image;

public class CardGameTools {
	
	public static Integer generateCardValue() {
		return (int) (Math.random() * 12) + 1;
	}
	
	public static Image loadCardImage(Integer cardValue) {
		String imagePath = "/unilim/info/ihm/tp6/exo3/view/" + cardValue + ".png";
		Image image = new Image(CardGameTools.class.getResourceAsStream(imagePath));
		return image;
	}

}
