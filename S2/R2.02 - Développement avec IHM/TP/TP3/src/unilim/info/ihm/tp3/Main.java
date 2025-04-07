package unilim.info.ihm.tp3;


import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;
import unilim.info.ihm.tp3.model.AchatCondiment;
import unilim.info.ihm.tp3.controller.ChoixPhotoController;

public class Main extends Application {
	@Override
	public void start(Stage primaryStage) {
		try {
			Label lblSauv = new Label("Sauvegarde de condiment");
			Label lblListe = new Label("Liste des condiments");
			Label lblNom = new Label("Nom * : ");
			Label lblType = new Label("Type * :");
			Label lblPrix = new Label("Prix * :");
			Label lblQuantite = new Label("Quantité * :");
			Label lblImage = new Label("Image * :");
			
			Label lblpath = new Label();
			
			Label lblErrorNom = new Label("Veuillez saisir le nom");
	        Label lblErrorPrix = new Label("Veuillez saisir le prix");
	        Label lblErrorQuantite = new Label("Veuillez saisir la quantité");
	        Label lblErrorImage = new Label("Veuillez sélectionner une image");
	        Label lblErrorType = new Label("Veuillez sélectionner un type");
			
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
			gridPaneGauche.add(lblpath, 0, 14);
			
			gridPaneGauche.add(btnPhoto, 0, 15);
			gridPaneGauche.add(btnSauvegarder, 0, 16);
						
			vBoxGauche.getChildren().addAll(gridPaneGauche);
			vBoxDroite.getChildren().addAll(lblListe);
			
			hBox.getChildren().addAll(vBoxGauche, vBoxDroite);
			
			HBox.setMargin(vBoxGauche, new Insets(10));
			
			vBoxDroite.setStyle("-fx-background-color: #D3D3D3;");
			
			vBoxGauche.setPrefWidth(300);
			vBoxDroite.setPrefWidth(400);
			
			tfNom.setPrefWidth(300);
			tfType.setPrefWidth(300);
			tfPrix.setPrefWidth(300);
			tfQuantite.setPrefWidth(300);
			btnPhoto.setPrefWidth(300);
			btnSauvegarder.setPrefWidth(300);

			lblSauv.setMaxWidth(Double.MAX_VALUE);
			lblSauv.setStyle("-fx-alignment: CENTER;");
			
			lblListe.setMaxWidth(Double.MAX_VALUE);
			lblListe.setStyle("-fx-alignment: CENTER;");
			
		      
			 btnPhoto.setOnAction(e -> {
				 ChoixPhotoController choixPhotoController = new ChoixPhotoController(lblpath, primaryStage);
				 btnPhoto.addEventHandler(MouseEvent.MOUSE_CLICKED, choixPhotoController);
			 });

			btnSauvegarder.setOnAction(e -> {
				String nom = tfNom.getText();
				String type = tfType.getText();
				String prix = tfPrix.getText();
				String quantite = tfQuantite.getText();

				String imagepath = lblpath.getText();
			
				
				if (tfNom.getText().isEmpty()) {
					if (!gridPaneGauche.getChildren().contains(lblErrorNom)) {
						gridPaneGauche.add(lblErrorNom, 0, 3);
				    }
					lblErrorNom.setTextFill(Color.RED);
					lblErrorNom.setFont(Font.font("Arial",FontWeight.BOLD, 12));
				} 
				else {
					gridPaneGauche.getChildren().remove(lblErrorNom);
				}
				
				
				if (tfPrix.getText().isEmpty()) {
					if (!gridPaneGauche.getChildren().contains(lblErrorPrix)) {
						gridPaneGauche.add(lblErrorPrix, 0, 9);
				    }
					lblErrorPrix.setTextFill(Color.RED);
					lblErrorPrix.setFont(Font.font("Arial",FontWeight.BOLD, 12));
				} 
				else {
					gridPaneGauche.getChildren().remove(lblErrorPrix);
				}
				
				if (tfQuantite.getText().isEmpty()) {
					if (!gridPaneGauche.getChildren().contains(lblErrorQuantite)) {
						gridPaneGauche.add(lblErrorQuantite, 0, 12);
				    }
					lblErrorQuantite.setTextFill(Color.RED);
					lblErrorQuantite.setFont(Font.font("Arial",FontWeight.BOLD, 12));
				} 
				else {
					gridPaneGauche.getChildren().remove(lblErrorQuantite);
				}
				
				if (tfType.getText().isEmpty() || (!tfType.getText().equals("Légume") && !tfType.getText().equals("Fruit"))) {
					if (!gridPaneGauche.getChildren().contains(lblErrorType)) {
						gridPaneGauche.add(lblErrorType, 0, 6);
				    }
					lblErrorType.setTextFill(Color.RED);
					lblErrorType.setFont(Font.font("Arial",FontWeight.BOLD, 12));
				} 
				else {
					gridPaneGauche.getChildren().remove(lblErrorType);
				}
				
				if (lblpath.getText().isEmpty()) {
					if (!gridPaneGauche.getChildren().contains(lblErrorImage)) {
						gridPaneGauche.add(lblErrorImage, 0, 17);
				    }
					lblErrorImage.setTextFill(Color.RED);
					lblErrorImage.setFont(Font.font("Arial",FontWeight.BOLD, 12));
				} 
				else {
					gridPaneGauche.getChildren().remove(lblErrorImage);
				}
				
				if (type.equals("Légume") || type.equals("Fruit")) {
				    Color couleur = type.equals("Légume") ? Color.GREEN : Color.RED;

				    Image image = new Image("file:" + imagepath);
				    ImageView imgView = new ImageView(image);
				    imgView.setFitWidth(100);
				    imgView.setFitHeight(100);
				    imgView.setPreserveRatio(true);
				    
				    AchatCondiment achat = new AchatCondiment(nom, couleur, imgView, prix, quantite);

				    GridPane grid = new GridPane();
				    grid.setHgap(10);  
				    grid.setVgap(5);  

				    Label lblNomprod = new Label("Nom :");
				    Label lblNomVal = new Label(nom);

				    Label lblPrixprod = new Label("Prix :");
				    Label lblPrixVal = new Label(prix + "€");

				    Label lblQuantiteprod = new Label("Quantité :");
				    Label lblQuantiteVal = new Label(quantite + " unités");

				    grid.add(lblNomprod, 0, 0);
				    grid.add(lblNomVal, 1, 0);
				    grid.add(lblPrixprod, 0, 1);
				    grid.add(lblPrixVal, 1, 1);
				    grid.add(lblQuantiteprod, 0, 2);
				    grid.add(lblQuantiteVal, 1, 2);

				    grid.add(imgView, 2, 0, 1, 3); 

				    grid.setPrefWidth(350);
				    grid.setMaxWidth(350);

				    grid.setStyle("-fx-background-color: " + (couleur == Color.GREEN ? "green" : "red") + "; -fx-alignment: center;");
				    
				    grid.setPadding(new Insets(10));

				    vBoxDroite.getChildren().add(grid);
				    
				    
				}
				});
			
			
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
