package unilim.info.ihm.tp6.exo2;

import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import unilim.info.ihm.tp6.exo2.controller.DndRectangleController;

public class DndRectangle extends Application {
	public void start(Stage primaryStage) {

		Text dragtext = new Text("Drag me!");
		dragtext.setX(50);
		dragtext.setY(50);
		dragtext.setFill(Color.BLACK);
		
		Rectangle dragRectangle = new Rectangle();
		dragRectangle.setWidth(150);
		dragRectangle.setHeight(100);
		dragRectangle.setX(50);
		dragRectangle.setY(100);
		dragRectangle.setFill(Color.BLUE);
		
		Text dropText = new Text("Drop here!");
		dropText.setX(300);
		dropText.setY(50);
		dropText.setFill(Color.BLACK);
		
		Rectangle dropRectangle = new Rectangle();
		dropRectangle.setWidth(150);
		dropRectangle.setHeight(100);
		dropRectangle.setX(300);
		dropRectangle.setY(200);
		dropRectangle.setFill(Color.RED);
		
		DndRectangleController.manageSourceDragAndDrop(dragRectangle);
		DndRectangleController.manageTargetDragAndDrop(dropRectangle);
		
		DndRectangleController.manageSourceDragAndDrop(dropRectangle);
		DndRectangleController.manageTargetDragAndDrop(dragRectangle);
		
		Group group = new Group(dropText, dragtext, dragRectangle, dropRectangle);
		Scene scene = new Scene(group, 500, 350);

		primaryStage.setTitle("Etude de Drag and Drop");
		primaryStage.setScene(scene);
		primaryStage.show();
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}
