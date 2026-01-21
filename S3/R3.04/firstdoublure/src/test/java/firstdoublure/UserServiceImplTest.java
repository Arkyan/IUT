package firstdoublure;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;
import org.junit.jupiter.api.Test;

class UserServiceImplTest {
	@Test
	void should_create_user_with_hashed_password() {
		UserService userService = new UserServiceImpl(new HashProvider() {
			@Override
			public String hash(String text) {
				return "???";
			}
		});
		User user = userService.createUser("Bob", "secret");
		assertEquals("Bob", user.firstName());
		assertEquals("???", user.hashedPassword());
	}
	
	@Test
    void should_create_user_with_hashed_password_Mock() {
        UserService userService = mock(UserServiceImpl.class);

        when(userService.createUser("Bob", "secret"))
            .thenReturn(new User("Bob", "secret"));

        userService.createUser("Bob", "secret");

        verify(userService).createUser("Bob", "secret");
    }
}