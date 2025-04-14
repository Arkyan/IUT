package testspractice;

public class StringUtils {

	public static boolean isPalindrome(String candidate) {
		String candidateReverse = reverse(candidate);
		return candidate.equals(candidateReverse);
	}

	public static String reverse(String candidate) {
		
		StringBuilder reverse = new StringBuilder();
		
		int length = candidate.length();
		for (int i = length - 1; i >= 0; i--) {
			reverse.append(candidate.charAt(i));
		}
		
		return reverse.toString();
	}

}