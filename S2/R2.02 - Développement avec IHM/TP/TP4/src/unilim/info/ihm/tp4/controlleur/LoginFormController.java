package unilim.info.ihm.tp4.controlleur;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

public class LoginFormController {

	    @FXML
	    private Button idBtnValider;

	    @FXML
	    private ComboBox<String> idCb;

	    @FXML
	    private Label idLibBas;

	    @FXML
	    private Label idLibErr;

	    @FXML
	    private PasswordField idPwd;

	    @FXML
	    private TextField idUser;

	    @FXML
	    void validerSaisies(ActionEvent event) {
	    	String user = idUser.getText();
	        String pwd = idPwd.getText();
	        String cb = idCb.getValue();

	        if (user.isEmpty() && pwd.isEmpty()) {
	            showError("Veuillez remplir les champs obligatoires");
	            idLibBas.setText("Aucun login saisi");
	            return;
	        }

	        if (user.isEmpty()) {
	            showError("La saisie du nom d'utilisateur est obligatoire");
	            idLibBas.setText("Aucun login saisi");
	            return;
	        }

	        if (pwd.isEmpty()) {
	            showError("La saisie du mot de passe est obligatoire");
	            idLibBas.setText("Aucun login saisi");
	            return;
	        }

	        idLibBas.setText("Login de <" + user +  "> pour application <" + cb + "> le " + java.time.LocalDate.now());
	    	}
	    
	    
	    @FXML
	    void initialize() {
	    	idLibErr.setText("");
	    	idLibBas.setText("Veuillez vous identifier");
	    	
	    	idBtnValider.setOnAction(event -> {
	    		validerSaisies(event);
	    	});
	    	
	    	String items[] = {"Comptabilite", "Gestion de production", "Paye"};
	    	idCb.getItems().addAll(items);
	    	idCb.setValue("Comptabilite");
	    }
	    
	    private void showError(String message) {
	        Alert alert = new Alert(AlertType.ERROR);
	        alert.setTitle("Erreur de saisie");
	        alert.setHeaderText(null);
	        alert.setContentText(message);
	        alert.showAndWait();
	    }

}

