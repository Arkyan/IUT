package unilim.info.ihm.tp1.exo2.controller;

import javafx.event.EventHandler;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;

public class FormInscriptionController {
	
	public void EventClick() {
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
	}
}
