package unilim.info.ihm.tp6.exo3.view;

import javafx.scene.image.ImageView;
import unilim.info.ihm.tp6.exo3.model.Card;
import unilim.info.ihm.tp6.exo3.tools.CardGameTools;

public class CardImageView extends ImageView {
	private Card card;
	
	public CardImageView(Card card) {
		this.card = card;
		this.setImage(CardGameTools.loadCardImage(card.getValue()));
		this.setFitWidth(150);
		this.setFitHeight(215);
	}
	
	public Card getCard() {
		return card;
	}
	

}
