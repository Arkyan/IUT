package unilim.info.ihm.tp5.exo2;

import javafx.animation.TranslateTransition;
import javafx.scene.input.KeyEvent;
import javafx.scene.shape.Rectangle;
import javafx.util.Duration;

public class MoveRectangleController {

    void handleKeyPress(KeyEvent event, Rectangle rect) {
        double distance = 10;
        double currentX = rect.getTranslateX();
        double newX = currentX;
        

        switch (event.getCode()) {
            case RIGHT -> newX += distance;
            case LEFT -> newX -= distance;
            default -> { return; }
        }
        
        newX = Math.max(50, Math.min(newX, 400));

        TranslateTransition transition = new TranslateTransition(Duration.millis(200), rect);
        transition.setToX(newX);
        transition.play();
    }
}
