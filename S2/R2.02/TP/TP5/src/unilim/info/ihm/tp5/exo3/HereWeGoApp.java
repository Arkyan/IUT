package unilim.info.ihm.tp5.exo3;


import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.layout.BackgroundPosition;
import javafx.scene.layout.BackgroundRepeat;
import javafx.scene.layout.BackgroundSize;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

public class HereWeGoApp extends Application {

    @Override
    public void start(Stage primaryStage) {
        Pane layoutPane = new Pane();
        layoutPane.setPrefSize(1200, 622);

        Image backgroundImage = new Image("file:src/unilim/info/ihm/tp5/exo3/niveau.jpg");
        BackgroundSize backgroundSize = new BackgroundSize(1200, 622, false, false, false, false);
        BackgroundImage background = new BackgroundImage(backgroundImage, BackgroundRepeat.NO_REPEAT, BackgroundRepeat.NO_REPEAT, BackgroundPosition.DEFAULT, backgroundSize);
        layoutPane.setBackground(new Background(background));
       
        Image marioImage = new Image("file:src/unilim/info/ihm/tp5/exo3/droite.png");
        ImageView marioImageView = new ImageView(marioImage);
        marioImageView.setFitWidth(20);
        marioImageView.setFitHeight(30);
        
        marioImageView.setX(14);
        marioImageView.setY(530);
        
        MoveMarioController controller = new MoveMarioController(layoutPane, marioImageView);
        
        layoutPane.getChildren().add(marioImageView);
        
        Scene scene = new Scene(layoutPane);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Here We Go");
        primaryStage.setResizable(false);
        primaryStage.show();
        layoutPane.requestFocus();

    }

    public static void main(String[] args) {
        launch(args);
    }
}
