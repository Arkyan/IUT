package gameofdices;

import java.util.Random;

public class Dice {
	private static final int FACES = 6;
	private Random rand;
	public Dice(Random rand) { this.rand = rand; }
	
	public int roll() {
		int result = rand.nextInt(FACES) + 1;
		if (result < 1 || result > FACES) {
			throw new RuntimeException("Dice returns an incompatible value");
		}
	return result;
	}
}