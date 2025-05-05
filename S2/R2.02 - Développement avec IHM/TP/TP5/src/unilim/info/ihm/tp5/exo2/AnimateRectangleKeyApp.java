package unilim.info.ihm.tp5.exo2;

import javafx.animation.AnimationTimer;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.layout.Pane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;

public class AnimateRectangleKeyApp extends Application {

    @Override
    public void start(Stage primaryStage) {
        Rectangle rectbleu = new Rectangle(150, 100);
        rectbleu.setFill(Color.BLUE);
        rectbleu.setX(50);
        rectbleu.setY(50);

        Button Btnreset = new Button("Reset");

        Pane root = new Pane();
        root.setStyle("-fx-background-color: lightgreen;");
        root.getChildren().addAll(rectbleu, Btnreset);

        Scene scene = new Scene(root, 600, 200);
        primaryStage.setTitle("Animation de Rectangle avec Clavier");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false);
        primaryStage.show();
        root.requestFocus();

        MoveRectangleController MRcontroller = new MoveRectangleController();
        scene.setOnKeyPressed(event -> MRcontroller.handleKeyPress(event, rectbleu));

        Btnreset.setOnAction(e -> {
            rectbleu.setTranslateX(0); 
        });
    }

    public static void main(String[] args) {
        launch(args);
    }
}
