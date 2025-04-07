package unilim.info.ihm.tp3;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class Main extends Application {
	@Override
	public void start(Stage primaryStage) {
		try {
			Label lblSauv = new Label("Sauvegarde de condiment");
			Label lblListe = new Label("Liste des condiments");
			Label lblNom = new Label("Nom");
			Label lblType = new Label("Type");
			Label lblPrix = new Label("Prix");
			Label lblQuantite = new Label("Quantité");
			Label lblImage = new Label("Image");
			
			Text Tpath = new Text();
			
			Button btnPhoto = new Button("Photo");
			Button btnSauvegarder = new Button("Sauvegarder");
			
			TextField tfNom = new TextField();
			TextField tfType = new TextField();
			TextField tfPrix = new TextField();
			TextField tfQuantite = new TextField();
			
			HBox hBox = new HBox();
			VBox vBoxGauche = new VBox();
			VBox vBoxDroite = new VBox();
			GridPane gridPaneGauche = new GridPane();
			
			gridPaneGauche.add(lblSauv, 0, 0);
			gridPaneGauche.add(lblNom, 0, 1);
			gridPaneGauche.add(tfNom, 0, 2);
			
			
			gridPaneGauche.add(lblType, 0, 4);
			gridPaneGauche.add(tfType, 0, 5);
			
			
			gridPaneGauche.add(lblPrix, 0, 7);
			gridPaneGauche.add(tfPrix, 0, 8);
			
			gridPaneGauche.add(lblQuantite, 0, 10);
			gridPaneGauche.add(tfQuantite, 0, 11);
			
			gridPaneGauche.add(lblImage, 0, 13);
			gridPaneGauche.add(Tpath, 0, 14);
			
			gridPaneGauche.add(btnPhoto, 0, 15);
			gridPaneGauche.add(btnSauvegarder, 0, 16);
			
			vBoxGauche.getChildren().addAll(gridPaneGauche);
			vBoxDroite.getChildren().addAll(lblListe);
			
			hBox.getChildren().addAll(vBoxGauche, vBoxDroite);
			
			Scene scene = new Scene(hBox, 700, 500);
			
			primaryStage.setTitle("Gestion des condiments");
			primaryStage.setScene(scene);
			primaryStage.show();
			primaryStage.setResizable(false);

		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		launch(args);
	}

}
