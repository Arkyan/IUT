package gameofdices;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Random;
import org.junit.jupiter.api.Test;

class PlayerTest {
	Player player;
	@Test
	void lastValueNotInitialized() {
		player = new Player("John Doe", new Dice(new Random()));
		assertFalse(player.getLastValue().isPresent());
	}

	@Test
	void lastValueInitialized() {
		player = new Player("John Doe", new Dice(new Random()));
		player.play();
		assertTrue(player.getLastValue().isPresent());
	}
	
	@Test
	void throwDiceOnlyTwice() {
		Dice dice = mock(Dice.class);
		player = new Player("John Doe", dice);
		player.play();
		verify(dice, times(2)).roll();
	}
	
	@Test
	void keepTheMaximum() {
		Dice dice = mock(Dice.class);
		player = new Player("John Doe", dice);
		when(dice.roll()).thenReturn(2).thenReturn(5);
		player.play();
		assertEquals(5, player.getLastValue().get());
		when(dice.roll()).thenReturn(6).thenReturn(1);
		player.play();
		assertEquals(6, player.getLastValue().get());
	}
}