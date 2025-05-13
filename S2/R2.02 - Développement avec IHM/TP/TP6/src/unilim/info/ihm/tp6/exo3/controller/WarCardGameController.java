package unilim.info.ihm.tp6.exo3.controller;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;

public class WarCardGameController {

    @FXML
    private Button idBtnChanger;

    @FXML
    private Button idBtnQuitter;

    @FXML
    private Pane idCardToBeat;

    @FXML
    private HBox idDeck;

    @FXML
    void changer(ActionEvent event) {
        //idDeck.getChildren().clear();
        //idDeck.getChildren().addAll(CardGameTools.generateCardValue(), CardGameTools.generateCardValue(), CardGameTools.generateCardValue());
    }

    @FXML
    void quitter(ActionEvent event) {
        System.exit(0);
    }
    
    @FXML
    void initialize() {
        //idDeck.getChildren().addAll(CardGameTools.generateCardValue(), CardGameTools.generateCardValue(), CardGameTools.generateCardValue());
        //idCardToBeat.getChildren().addAll(CardGameTools.generateCardValue());
    }
    
}