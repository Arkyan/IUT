package unilim.info.ihm.tp6.exo3.tools;

import javafx.scene.image.ImageView;

public class CardGameTools {
	
	public static Integer generateCardValue() {
		return (int) (Math.random() * 12) + 1;
	}
	
	public static ImageView loadCardImage(Integer cardValue) {
		String imagePath = "/unilim/info/ihm/tp6/exo3/images/" + cardValue + ".png";
		ImageView imageView = new ImageView(imagePath);
		imageView.setFitWidth(100);
		imageView.setFitHeight(150);
		return imageView;
	}

}
