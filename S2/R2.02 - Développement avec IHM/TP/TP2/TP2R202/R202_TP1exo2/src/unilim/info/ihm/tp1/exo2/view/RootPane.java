package unilim.info.ihm.tp1.exo2.view;

import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class RootPane  {
	
	public void init(Stage primaryStage) {
		Label lblTitre = new Label();
        Label lblSousTitre = new Label();
        Button btnSouscrire = new Button();

        
        lblTitre.setText("Inscription à la newsletter");
        lblTitre.setStyle("-fx-underline: true;");
        lblSousTitre.setText("Inscrivez-vous pour recevoir notre newsletter");
        btnSouscrire.setText("Souscrire");

		
		
		FormInscriptionPane formInscriptionPane = new FormInscriptionPane();
		formInscriptionPane.majLabel();
		
		
	}
	

}
