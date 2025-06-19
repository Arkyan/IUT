package unilim.info.ihm.tp4;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class LoginAppSb extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("vue/LoginForm.fxml"));
        Scene scene = new Scene(loader.load(), 600, 170);
        primaryStage.setTitle("Application de Login avec SceneBuilder");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}