package gameboard.model.material.array2d;

import gameboard.model.material.Constants;
import gameboard.model.material.Disc;
import gameboard.model.material.IGameBoard;
import gameboard.model.material.Position;

public class GameBoard2D implements IGameBoard {

	Disc[][] discs;

	public GameBoard2D() {
		this.discs = new Disc[Constants.ROWS][Constants.COLUMNS];
	}

	public Disc[][] discs() {
		return discs;
	}

	@Override
	public boolean isDiscAt(Position position) {
		if (position == null || position.row() == null || position.column() == null)
			return false;

		int row = position.row();
		int col = position.column();

		return row >= 0 && row < Constants.ROWS
			&& col >= 0 && col < Constants.COLUMNS
			&& discs[row][col] != null;
	}


	@Override
	public boolean isEmpty() {
		for (int row = 0; row < Constants.ROWS; row++) {
			for (int column = 0; column < Constants.COLUMNS; column++) {
				if (discs[row][column] != null) {
					return false;
				}
			}
		}
		return true;
	}

	@Override
	public boolean put(Position position, Disc disc) {
		if (position == null || disc == null
				|| position.row() == null || position.column() == null) {
			return false;
		}

		int row = position.row();
		int col = position.column();

		if (row < 0 || row >= Constants.ROWS || col < 0 || col >= Constants.COLUMNS) {
			return false;
		}

		if (discs[row][col] == null) {
			discs[row][col] = disc;
			return true;
		}

		return false;
	}

	@Override
	public void clear() {
		for (int row = 0; row < Constants.ROWS; row++) {
			for (int column = 0; column < Constants.COLUMNS; column++) {
				discs[row][column] = null;
			}
		}
	}

	@Override
	public int howManyDiscsOnBoard() {
		int count = 0;
		for (int row = 0; row < Constants.ROWS; row++) {
			for (int column = 0; column < Constants.COLUMNS; column++) {
				if (discs[row][column] != null) {
					count++;
				}
			}
		}
		return count;
	}

	@Override
	public Disc discAt(Position position) {
		if (position.row() < 0 || position.row() >= Constants.ROWS
				|| position.column() < 0 || position.column() >= Constants.COLUMNS) {
			return null;
		}
		return discs[position.row()][position.column()];
	}

	@Override
	public Disc removeDiscAt(Position position) {
		if (position.row() < 0 || position.row() >= Constants.ROWS
				|| position.column() < 0 || position.column() >= Constants.COLUMNS) {
			return null;
		}
		Disc disc = discs[position.row()][position.column()];
		discs[position.row()][position.column()] = null;
		return disc;
	}

	@Override
	public String toAscii() {
		StringBuilder sb = new StringBuilder();
		for (int row = 0; row < Constants.ROWS; row++) {
			for (int column = 0; column < Constants.COLUMNS; column++) {
				if (discs[row][column] != null) {
					sb.append(discs[row][column].toString());
				} else {
					sb.append(" . ");
				}
			}
			sb.append("\n");
		}
		return sb.toString();
	}
}
