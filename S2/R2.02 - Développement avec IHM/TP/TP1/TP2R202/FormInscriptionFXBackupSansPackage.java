package unilim.info.ihm.tp1.exo2;

import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;

public class FormInscriptionFX extends Application {
    @Override
    public void start(Stage primaryStage) {
        try {
            Button btnSouscrire = new Button();
            ComboBox<String> cbCivilite = new ComboBox<>();
            Label lblTitre = new Label();
            Label lblSousTitre = new Label();
            Label lblCivilite = new Label();
            Label lblNom = new Label();
            Label lblPrenom = new Label();
            Label lblAdresseMail = new Label();
            Label lblConfAdresseMail = new Label();
            
            Label lblErrNom = new Label();
            Label lblErrPrenom = new Label();
            Label lblErrAdresseMail = new Label();
            Label lblErrConfAdresseMail = new Label();
            Label lblErrCondition = new Label();
            
            Label lblInscription = new Label();
            CheckBox cbCondition = new CheckBox(); 
            TextField tfNom = new TextField();
            TextField tfPrenom = new TextField();
            TextField tfAdresseMail = new TextField();
            TextField tfConfAdresseMail = new TextField();
            
            btnSouscrire.setText("S'inscrire");
            lblTitre.setText("Inscription à la newsletter");
            lblTitre.setStyle("-fx-underline: true;");
            lblSousTitre.setText("Inscrivez-vous pour recevoir notre newsletter");
            lblCivilite.setText("Civilité :");
            lblNom.setText("Nom :");
            lblPrenom.setText("Prénom :");
            lblAdresseMail.setText("Adresse mail :");
            lblConfAdresseMail.setText("Confirmer adresse mail :");
            cbCondition.setText("J'accepte les conditions d'utilisation");
            lblInscription.setText("Utilisateur non inscrit !");
            
            lblErrNom.setText("Le nom est obligatoire !");
            lblErrPrenom.setText("Le prénom est obligatoire !");
            lblErrAdresseMail.setText("Le mail est obligatoire !");
            lblErrConfAdresseMail.setText("La vérification du mail est obligatoire !");
            lblErrCondition.setText("Il faut accepter CGU !");
            
            cbCivilite.getItems().addAll("M.", "Mme", "Mlle");
            cbCivilite.setValue("M.");

            BorderPane root = new BorderPane();
            VBox vboxGlobal = new VBox();
            root.setCenter(vboxGlobal);
            GridPane gridLeft = new GridPane();

            VBox vboxTop = new VBox(10, lblTitre, lblSousTitre);
            vboxTop.setAlignment(Pos.CENTER); 

            HBox hboxTop = new HBox(vboxTop);
            hboxTop.setAlignment(Pos.CENTER);

            root.setTop(hboxTop);
                        
            root.setBottom(cbCondition);
            root.setBottom(btnSouscrire);
            
            BorderPane.setAlignment(btnSouscrire, Pos.CENTER);
            BorderPane.setMargin(btnSouscrire, new Insets(10, 0, 10, 0));
            
            VBox vboxBot = new VBox(10, btnSouscrire, lblInscription );
            vboxBot.setAlignment(Pos.CENTER);
                        
            gridLeft.add(lblCivilite, 0, 0);
            gridLeft.add(cbCivilite, 0, 1);
            
            gridLeft.add(lblNom, 0, 2);
            gridLeft.add(tfNom, 0, 3);
            
            gridLeft.add(lblAdresseMail, 0, 5);
            gridLeft.add(tfAdresseMail, 0, 6);
            
            gridLeft.add(lblPrenom, 1, 2);
            gridLeft.add(tfPrenom, 1, 3);
            
            gridLeft.add(lblConfAdresseMail, 1, 5);
            gridLeft.add(tfConfAdresseMail, 1, 6);
                        
            VBox vboxBotCenter = new VBox(0, cbCondition);
            vboxBotCenter.setPadding(new Insets(20, 0, 0, 0));

            vboxGlobal.getChildren().addAll(gridLeft, vboxBotCenter);

            VBox vboxBottom = new VBox(10, btnSouscrire, lblInscription);

            vboxBottom.setAlignment(Pos.CENTER);

            root.setBottom(vboxBottom);
            
            BorderPane.setMargin(vboxGlobal, new Insets(10, 10, 10, 10));
            
            gridLeft.setHgap(10);
            gridLeft.setVgap(10);
            
            
            btnSouscrire.setOnMouseClicked(new EventHandler<MouseEvent>() {
				@Override
				public void handle(MouseEvent event) {
					if (tfNom.getText().isEmpty() || tfPrenom.getText().isEmpty() || tfAdresseMail.getText().isEmpty() || tfConfAdresseMail.getText().isEmpty() || !cbCondition.isSelected() || !tfAdresseMail.getText().equals(tfConfAdresseMail.getText())) {
						lblInscription.setText("Utilisateur non inscrit !");
					}
					else {
						String civilite = cbCivilite.getValue();
						String nom = tfNom.getText();
						String prenom = tfPrenom.getText();
						
						lblInscription.setTextFill(Color.BLACK);
						lblInscription.setFont(Font.font("Arial", 12));
						lblInscription.setText(civilite + " " + nom + " " + prenom + " " + "s'est inscrit(e) " + "le " + java.time.LocalDate.now() + " à " + java.time.LocalTime.now());
					}
					
					if (tfNom.getText().isEmpty()) {
						if (!gridLeft.getChildren().contains(lblErrNom)) {
					        gridLeft.add(lblErrNom, 0, 4);
					    }
						lblErrNom.setTextFill(Color.RED);
						lblErrNom.setFont(Font.font("Arial",FontWeight.BOLD, 12));
					} 
					else {
						gridLeft.getChildren().remove(lblErrNom);
					}
						
					
					if (tfPrenom.getText().isEmpty()) {
						if (!gridLeft.getChildren().contains(lblErrPrenom)) {
					        gridLeft.add(lblErrPrenom, 1, 4);
					    }
						lblErrPrenom.setTextFill(Color.RED);
						lblErrPrenom.setFont(Font.font("Arial",FontWeight.BOLD, 12));
					} 
					else {
						gridLeft.getChildren().remove(lblErrPrenom);
					}
						
					
					if (tfAdresseMail.getText().isEmpty()) {
						if (!gridLeft.getChildren().contains(lblErrAdresseMail)) {
					        gridLeft.add(lblErrAdresseMail, 0, 7);
					    }
						lblErrAdresseMail.setTextFill(Color.RED);
						lblErrAdresseMail.setFont(Font.font("Arial",FontWeight.BOLD, 12));
						
					} 
					else {
						gridLeft.getChildren().remove(lblErrAdresseMail);
					}
					
					
					if (tfConfAdresseMail.getText().isEmpty()) {
						if (!gridLeft.getChildren().contains(lblErrConfAdresseMail)) {
					        gridLeft.add(lblErrConfAdresseMail, 1, 7);
					    }
						lblErrConfAdresseMail.setTextFill(Color.RED);
						lblErrConfAdresseMail.setFont(Font.font("Arial",FontWeight.BOLD, 12));
					} 
					else {
						gridLeft.getChildren().remove(lblErrConfAdresseMail);
					}
						
						
					if (!cbCondition.isSelected()) {
						if (!vboxBotCenter.getChildren().contains(lblErrCondition)) {
							vboxBotCenter.getChildren().add(lblErrCondition);
					    }
						lblErrCondition.setTextFill(Color.RED);
						lblErrCondition.setFont(Font.font("Arial",FontWeight.BOLD, 12));
					} 
					else {	
						vboxBotCenter.getChildren().remove(lblErrCondition);
					}
					
					
					if (!tfAdresseMail.getText().equals(tfConfAdresseMail.getText())) {
						lblInscription.setText("Les adresses mails ne correspondent pas !");
						lblInscription.setTextFill(Color.RED);
						lblInscription.setFont(Font.font("Arial",FontWeight.BOLD, 12));
					}
				}	
			});

            Scene scene = new Scene(root, 600, 450);
            primaryStage.setScene(scene);
            primaryStage.setTitle("Application Newsletter");
            primaryStage.show();

            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
