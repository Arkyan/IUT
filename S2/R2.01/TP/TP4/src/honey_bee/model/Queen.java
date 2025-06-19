package honey_bee.model;

public class Queen extends HoneyBee {

    public Queen(String name) {
        super(name);
    }

    @Override
    public String doYourJob(){
        return super.doYourJob() + " I'm a Queen, any question";
    }
}
