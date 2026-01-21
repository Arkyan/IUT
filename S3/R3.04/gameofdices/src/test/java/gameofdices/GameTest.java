package gameofdices;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import java.util.Optional;
import org.junit.jupiter.api.Test;

class GameTest {
	Game game;
	@Test
	void andTheWinnerIs() {
		Player player1 = mock(Player.class);
		when(player1.getLastValue()).thenReturn(Optional.of(5));
		
		Player player2 = mock(Player.class);
		when(player2.getLastValue()).thenReturn(Optional.of(2));
			
		game = new Game(player1, player2);
		assertEquals(player1, game.play().get());
	}
	
	@Test
	void noWinnerAfter5Attempts() {
		Dice single = mock(Dice.class);
		when(single.roll()).thenReturn(1);
		
		Player player1 = spy(new Player("John", single));
		Player player2 = spy(new Player("Jane", single));
		
		game = new Game(player1,player2);
		assertFalse(game.play().isPresent());
		verify(player1, times(5)).play();
		verify(player2, times(5)).play();
	}
}