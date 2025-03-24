	package computerpioneer;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

import computerpioneer.model.Device;

class DeviceTest {
	
	@Test
	public void create_device(){
		Device babbageMachine = new Device("Babbage Analytical Machine", 1837);
		assertEquals("The Babbage Analytical Machine was invented in 1837. ", babbageMachine.toString());
	}
}
