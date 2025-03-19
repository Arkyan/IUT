package computerpioneer;
import computerpioneer.model.ComputerPioneer;
import computerpioneer.model.Device;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class ComputerPioneerTest {

	@Test
	void create_computerPioneer_with_device() {
		Device babbageMachine = new Device("Babbage Analytical Machine", 1837);
		ComputerPioneer adaLovelace = new ComputerPioneer("Lovelace", "Ada", babbageMachine);
		assertEquals("Ada Lovelace is a computer pioneer", adaLovelace.toString());
	}
	
	@Test
	void computerPioneer_should_worksOn_device() {
		Device babbageMachine = new Device("Babbage Analytical Machine", 1837);
		ComputerPioneer adaLovelace = new ComputerPioneer("Lovelace", "Ada", babbageMachine);
		Device turingEngine = new Device("Turing Engine", 1936);
		ComputerPioneer alanTuring = new ComputerPioneer("Turing", "Alan", turingEngine);
		assertTrue(adaLovelace.worksOn(babbageMachine));
		assertFalse(adaLovelace.worksOn(turingEngine));
		assertFalse(alanTuring.worksOn(babbageMachine));
		assertTrue(alanTuring.worksOn(turingEngine));
	}

}
