package unilim.info.ihm.tp6.exo1.controller;

import javafx.scene.input.ClipboardContent;
import javafx.scene.input.Dragboard;
import javafx.scene.input.TransferMode;
import javafx.scene.text.Text;

public class DndTextController {

	public static void manageSourceDragAndDrop(Text source) {
		source.setOnDragDetected(event -> {
			Dragboard db = source.startDragAndDrop(TransferMode.COPY);
			ClipboardContent content = new ClipboardContent();
			content.putString(source.getText());
			db.setContent(content);
			event.consume();
		});

		source.setOnDragDone(event -> {
			event.consume();
		});
	}
	
	public static void manageTargetDragAndDrop(Text target) {
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
				target.setText(db.getString());
				success = true;
			}
			event.setDropCompleted(success);
			event.consume();
		});
	}
}
