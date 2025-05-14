package unilim.info.ihm.tp6.exo2.controller;

import javafx.scene.input.ClipboardContent;
import javafx.scene.input.Dragboard;
import javafx.scene.input.TransferMode;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

public class DndRectangleController {	
	public static void manageSourceDragAndDrop(Rectangle source) {
		source.setOnDragDetected(event -> {
			Dragboard db = source.startDragAndDrop(TransferMode.COPY);
			ClipboardContent content = new ClipboardContent();
			content.putString(source.getFill().toString());
			db.setContent(content);
			event.consume();
		});
		
		source.setOnDragDone(event -> {
			event.consume();
		});
	}
	
	public static void manageTargetDragAndDrop(Rectangle target) {
		target.setOnDragOver(event -> {
			if (event.getGestureSource() != target && event.getDragboard().hasString()) {
				event.acceptTransferModes(TransferMode.COPY);
			}
			event.consume();
		});

		target.setOnDragDropped(event -> {
			Dragboard db = event.getDragboard();
			boolean success = false;
			if (db.hasString()) {
				Color sourceColor = Color.web(db.getString());
				Color targetColor = (Color) target.getFill();

				target.setFill(sourceColor);
				
				if (event.getGestureSource() instanceof Rectangle sourceRect) {
					sourceRect.setFill(targetColor);
				}
				
				success = true;
			}
			event.setDropCompleted(success);
			event.consume();
		});
	}


}
