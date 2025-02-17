public class Worker extends HoneyBee{

    public Worker(String name){
        super(name);
    }

    public String doYourJob() {
        return super.doYourJob() + " I'm a worker, I work all day!";
    }
}
