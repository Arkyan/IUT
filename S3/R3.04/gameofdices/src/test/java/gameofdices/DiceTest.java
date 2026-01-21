package gameofdices;

import static org.junit.jupiter.api.Assertions.*;

import java.util.Random;

import org.junit.jupiter.api.Test;

class DiceTest {
	Dice theDice;

	@Test
	void rollReturnsAValue() {
		theDice = new Dice(new Random());
		for (int i = 0; i < 100; i++) {
			int result = theDice.roll();
			assertTrue(result >= 1);
			assertTrue(result <= 6);
		}
	}
	
	@Test
	void identifyBadValuesGreaterThanNumberOfFaces() {
		theDice = new Dice(new Random() {
			@Override
			public int nextInt(int bound) {
				return 6; // always return a value greater than the number of faces
			}
		});
		assertThrows(RuntimeException.class, theDice::roll);
	}
	
	@Test
	void identifyBadValuesLesserThanOne() {
		theDice = new Dice(new Random() {
			@Override
			public int nextInt(int bound) {
				return -1; // always return a value lesser than 1
			}
		});
		assertThrows(RuntimeException.class, () -> theDice.roll());
	}
	
}
