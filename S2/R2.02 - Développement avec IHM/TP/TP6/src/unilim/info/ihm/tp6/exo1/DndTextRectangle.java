package unilim.info.ihm.tp6.exo1;

import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import unilim.info.ihm.tp6.exo1.controller.DndTextController;

public class DndTextRectangle extends Application {
	public void start(Stage primaryStage) {

		Text dragtext = new Text("Drag me!");
		dragtext.setX(50);
		dragtext.setY(50);
		dragtext.setFill(Color.BLACK);
		
		Text dropText = new Text("Drop here!");
		dropText.setX(300);
		dropText.setY(50);
		dropText.setFill(Color.BLACK);

		DndTextController.manageSourceDragAndDrop(dragtext);
		DndTextController.manageTargetDragAndDrop(dropText);

		Group group = new Group(dropText, dragtext);
		Scene scene = new Scene(group, 400, 100);

		primaryStage.setTitle("Etude de Drag and Drop");
		primaryStage.setScene(scene);
		primaryStage.show();
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}