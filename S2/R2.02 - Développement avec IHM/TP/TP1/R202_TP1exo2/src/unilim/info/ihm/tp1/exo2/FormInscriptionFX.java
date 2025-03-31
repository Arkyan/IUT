package unilim.info.ihm.tp1.exo2;

import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;

public class FormInscriptionFX extends Application {
    @Override
    public void start(Stage primaryStage) {
        try {
            Button btn = new Button();
            ComboBox<String> cbCivilite = new ComboBox<>();
            Label lblTitre = new Label();
            Label lblSousTitre = new Label();
            Label lblCivilite = new Label();
            Label lblNom = new Label();
            Label lblPrenom = new Label();
            Label lblAdresseMail = new Label();
            Label lblConfAdresseMail = new Label();
            TextField tfNom = new TextField();
            TextField tfPrenom = new TextField();
            TextField tfAdresseMail = new TextField();
            TextField tfConfAdresseMail = new TextField();
            
            btn.setText("S'inscrire");
            lblTitre.setText("Inscription à la newsletter");
            lblTitre.setStyle("-fx-underline: true;");
            lblSousTitre.setText("Inscrivez-vous pour recevoir notre newsletter");
            lblCivilite.setText("Civilité :");
            lblNom.setText("Nom :");
            lblPrenom.setText("Prénom :");
            lblAdresseMail.setText("Adresse mail :");
            lblConfAdresseMail.setText("Confirmer adresse mail :");
            
            cbCivilite.getItems().addAll("M.", "Mme", "Mlle");
            cbCivilite.setValue("M.");

            BorderPane root = new BorderPane();
            GridPane gridLeft = new GridPane();

            VBox vboxTop = new VBox(10, lblTitre, lblSousTitre);
            vboxTop.setAlignment(Pos.CENTER); 

            HBox hboxTop = new HBox(vboxTop);
            hboxTop.setAlignment(Pos.CENTER);

            root.setTop(hboxTop);
            root.setLeft(gridLeft);
            root.setBottom(btn);
            BorderPane.setAlignment(btn, Pos.CENTER);
            BorderPane.setMargin(btn, new Insets(10, 0, 10, 0));

            gridLeft.add(lblCivilite, 0, 0);
            gridLeft.add(cbCivilite, 0, 1);
            
            gridLeft.add(lblNom, 0, 2);
            gridLeft.add(tfNom, 0, 3);
            
            gridLeft.add(lblPrenom, 1, 2);
            gridLeft.add(tfPrenom, 1, 3);
            
            gridLeft.add(lblAdresseMail, 0, 4);
            gridLeft.add(tfAdresseMail, 0, 5);
            
            gridLeft.add(lblConfAdresseMail, 1, 4);
            gridLeft.add(tfConfAdresseMail, 1, 5);
            
            BorderPane.setMargin(gridLeft, new Insets(10, 10, 10, 10));
            
            //Décalage des labels et tf en colonne 1
            gridLeft.setHgap(10);
            gridLeft.setVgap(10);
            

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
