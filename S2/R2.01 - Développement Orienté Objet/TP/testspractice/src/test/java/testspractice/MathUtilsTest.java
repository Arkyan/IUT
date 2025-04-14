package testspractice;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;


public class MathUtilsTest {
	
	@Test
	public void testIsDivisibleBy() {
		assertTrue(MathUtils.isDivisibleBy(2, 4));
		assertTrue(MathUtils.isDivisibleBy(3, 9));
		assertFalse(MathUtils.isDivisibleBy(5, 14));
		assertFalse(MathUtils.isDivisibleBy(7, 20));
	}
	
	@Test
	public void testIsDivisibleByZero() {
		assertThrows(ArithmeticException.class, () -> {
			MathUtils.isDivisibleBy(0, 10);
		});
	}

}
