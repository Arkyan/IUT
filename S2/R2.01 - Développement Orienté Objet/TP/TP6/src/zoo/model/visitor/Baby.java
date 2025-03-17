package zoo.model.visitor;
import zoo.model.Noisy;

public class Baby extends Child implements Noisy {
	public Baby() {
		super(1);
	};
	
	@Override
	public String whoAmI() {
		return super.whoAmI() + "I'm under 1 year old : I'm a baby. ";
	}
	
	@Override
	public Integer priceOfTicket() {
		return 0;
	}

	@Override
	public String noise() {
		return "Waaaaaah!";
	}
	

}
