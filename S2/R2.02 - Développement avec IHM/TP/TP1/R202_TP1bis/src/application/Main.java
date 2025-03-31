package application;
	
import javafx.application.Application;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.StackPane;


public class Main extends Application {
	@Override
	public void start(Stage primaryStage) {
		try {
			StackPane root = new StackPane();
			Button btn = new Button();
			btn.setText("Valider");
			
			root.getChildren().add(btn);
			Scene scene = new Scene(root, 600, 250);
			primaryStage.setTitle("Première fenêtre JavaFX");
			primaryStage.setScene(scene);
			
			primaryStage.show();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}
