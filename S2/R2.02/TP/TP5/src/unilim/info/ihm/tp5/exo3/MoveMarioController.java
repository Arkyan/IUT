package unilim.info.ihm.tp5.exo3;

import javafx.animation.SequentialTransition;
import javafx.animation.TranslateTransition;
import javafx.event.EventHandler;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.Pane;
import javafx.util.Duration;

public class MoveMarioController {

    private ImageView marioImageView;
    private Pane layoutPane;

    public MoveMarioController(Pane layoutPane, ImageView marioImageView) {
        this.layoutPane = layoutPane;
        this.marioImageView = marioImageView;
        
        layoutPane.setOnKeyPressed(new EventHandler<KeyEvent>() {
            @Override
            public void handle(KeyEvent event) {
            	déplacerMario(event);
            }
        });
        
        layoutPane.setFocusTraversable(true);
    }

    void déplacerMario(KeyEvent event) {
        double currentX = marioImageView.getX();
        double currentY = marioImageView.getY();
        

        if (event.getCode() == KeyCode.Z || event.getCode() == KeyCode.UP) {
            marioImageView.setY(currentY - 20); 
            MarioImage("up");
        } else if (event.getCode() == KeyCode.S || event.getCode() == KeyCode.DOWN) {
            marioImageView.setY(currentY + 20); 
            MarioImage("down");
        } else if (event.getCode() == KeyCode.Q || event.getCode() == KeyCode.LEFT) {
            marioImageView.setX(currentX - 20);  
            MarioImage("left");            
        } else if (event.getCode() == KeyCode.D || event.getCode() == KeyCode.RIGHT) {
            marioImageView.setX(currentX + 20); 
            MarioImage("right");
        }
        else if (event.getCode() == KeyCode.SPACE) {
        	if (marioImageView.getImage().getUrl().contains("droite.png")) {
				sautTransition(marioImageView, "RIGHT");
			} else if (marioImageView.getImage().getUrl().contains("gauche.png")) {
				sautTransition(marioImageView, "LEFT");
			}
		}
    }

    private void MarioImage(String direction) {
        String imagePath = "/unilim/info/ihm/tp5/exo3/";

        switch (direction) {
            case "up":
                imagePath += "haut.png";
                break;
            case "down":
                imagePath += "bas.png";
                break;
            case "left":
                imagePath += "gauche.png";
                break;
            case "right":
                imagePath += "droite.png";
                break;
        }

        Image marioImage = new Image(getClass().getResource(imagePath).toExternalForm());
        marioImageView.setImage(marioImage);
    }
    
    private void sautTransition(ImageView mario, String direction) {
        double currentX = mario.getLayoutX();
        double currentY = mario.getLayoutY();

        double targetX = direction.equals("RIGHT") ? currentX + 50 : currentX - 50;
        double targetY = currentY - 50;
        
        mario.setTranslateX(0);
        mario.setTranslateY(0);

        TranslateTransition jumpUp = new TranslateTransition(Duration.millis(200), mario);
        jumpUp.setToX(targetX - currentX);
        jumpUp.setToY(targetY - currentY);

        TranslateTransition fallDown = new TranslateTransition(Duration.millis(200), mario);
        fallDown.setToX(targetX - currentX);
        fallDown.setToY(0);

        fallDown.setOnFinished(e -> {
            mario.setLayoutX(targetX);
            mario.setLayoutY(currentY);
            mario.setTranslateX(0);
            mario.setTranslateY(0);
        });

        SequentialTransition jumpSequence = new SequentialTransition(jumpUp, fallDown);
        jumpSequence.play();
    }
}

