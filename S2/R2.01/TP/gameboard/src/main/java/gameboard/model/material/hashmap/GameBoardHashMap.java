package gameboard.model.material.hashmap;

import java.util.HashMap;
import java.util.Map;

import gameboard.model.material.Constants;
import gameboard.model.material.Disc;
import gameboard.model.material.IGameBoard;
import gameboard.model.material.Position;

public class GameBoardHashMap implements IGameBoard {

	private final Map<Position, Disc> discs;

	public GameBoardHashMap() {
		this.discs = new HashMap<>();
	}

	public Map<Position, Disc> discs() {
		return discs;
	}

	public boolean isDiscAt(Position position) {
		return discs.containsKey(position);
	}

	public boolean isEmpty() {
		return discs.isEmpty();
	}

	public boolean put(Position position, Disc disc) {
		if (position == null || disc == null || position.row() < 0 || position.row() >= Constants.ROWS
				|| position.column() < 0 || position.column() >= Constants.COLUMNS) {
			return false;
		}
		if (!discs.containsKey(position)) {
			discs.put(position, disc);
			return true;
		}
		return false;
	}

	public void clear() {
		discs.clear();
	}

	public int howManyDiscsOnBoard() {
		return discs.size();
	}

	public Disc discAt(Position position) {
		return discs.get(position);
	}

	public Disc removeDiscAt(Position position) {
		return discs.remove(position);
	}
	
	public void printDiscNearby(Position position) {
		for (int i = 0; i <= Constants.COLUMNS; i++) {
			for (int j = 0; j <= Constants.ROWS; j++) {
				if (i == 0 && j == 0) continue;
				Position nearbyPosition = new Position(position.row() + i, position.column() + j);
				if (discs.containsKey(nearbyPosition)) {
					System.out.println("Nearby disc at: " + nearbyPosition + " - " + discs.get(nearbyPosition));
				}
			}
		}
	}

	public String toAscii() {
		return "";
		//TODO
	}

}