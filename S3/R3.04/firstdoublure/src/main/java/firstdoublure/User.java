package firstdoublure;

public class User {
	private final String firstName;
	private final String hashedPassword;
	
	public User(String firstName, String hashedPassword) {
		this.firstName = firstName;
		this.hashedPassword = hashedPassword;
	}
	
	public String firstName() {
		return firstName;
	}
	
	public String hashedPassword() {
		return hashedPassword;
	}
	
}