package unilim.info.ihm.tp5.exo1;

import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;

public class AnimateRectangleApp extends Application {
	
	public void start(Stage primaryStage) {
        Rectangle rectbleu = new Rectangle(150, 100);
        rectbleu.setFill(Color.BLUE);
        rectbleu.setX(50);
        rectbleu.setY(50);

        Button Btnreset = new Button("Reset");        

        
        	
        Pane root = new Pane();
        root.getChildren().addAll(rectbleu, Btnreset);
        root.setStyle("-fx-background-color: lightgreen;");

        Scene scene = new Scene(root, 600, 200);
        primaryStage.setTitle("Animation de Rectangle");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false); 
        primaryStage.show();
        
        new AnimationTimer() {
			@Override
			public void handle(long now) {
				if (rectbleu.getX() < 400) {
					rectbleu.setX(rectbleu.getX() + 1);
				} else {
					this.stop();
				}
			}
		}.start();
		
		Btnreset.setOnAction(e -> {
			rectbleu.setX(50);
			this.start(primaryStage);
		});
		
	}

    public static void main(String[] args) {
        launch(args);
    }

}
