package unilim.info.ihm.tp1.exo2.view;

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

public class FormInscriptionPane {
	
	Button btnSouscrire = new Button();
    ComboBox<String> cbCivilite = new ComboBox<>();
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
    
    public void majLabel() {
    	btnSouscrire.setText("S'inscrire");
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
        
        BorderPane.setAlignment(btnSouscrire, Pos.CENTER);
        BorderPane.setMargin(btnSouscrire, new Insets(10, 0, 10, 0));
                    
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
        
        BorderPane.setMargin(vboxGlobal, new Insets(10, 10, 10, 10));
        
        gridLeft.setHgap(10);
        gridLeft.setVgap(10);
    }
    
}
