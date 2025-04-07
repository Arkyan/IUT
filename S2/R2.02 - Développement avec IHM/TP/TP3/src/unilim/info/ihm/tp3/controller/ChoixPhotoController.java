package unilim.info.ihm.tp3.controller;

import javafx.event.EventHandler;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;

import java.io.File;

public class ChoixPhotoController implements EventHandler<MouseEvent> {

    private Stage mainStage;
    private Label lblPhoto;

    public ChoixPhotoController(Label lblPhoto, Stage mainStage) {
        this.lblPhoto = lblPhoto;
        this.mainStage = mainStage;
    }

    @Override
    public void handle(MouseEvent mouseEvent) { 
        FileChooser fileChooser = new FileChooser();
        fileChooser.getExtensionFilters().addAll(
                new FileChooser.ExtensionFilter("Images", "*.png", "*.jpg", "*.jpeg", "*.gif")
        );
        File file = fileChooser.showOpenDialog(mainStage);
        if (file != null) {
            lblPhoto.setText(file.getAbsolutePath());
            lblPhoto.maxWidth(300);
        }

    }
}