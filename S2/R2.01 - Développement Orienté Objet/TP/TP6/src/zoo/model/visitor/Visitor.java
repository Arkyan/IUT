package zoo.model.visitor;

public abstract class Visitor {
	
	protected Integer REGULAR_TICKET = 10;
	
	public String sayHello() {
		return "Hello! I'm a visitor. ";
	}
	
	public abstract String whoAmI();
	
	public abstract Integer priceOfTicket();

}
