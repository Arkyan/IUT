package testspractice;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class StringUtilsTest {
	
	@Test
	void verifyPalindrome() {
		assertTrue(StringUtils.isPalindrome("racecar"));
		assertTrue(StringUtils.isPalindrome("a"));
		assertTrue(StringUtils.isPalindrome(""));
		assertFalse(StringUtils.isPalindrome("hello"));
		assertFalse(StringUtils.isPalindrome("world"));
		assertFalse(StringUtils.isPalindrome("kaya"));
	}

}
