public class Main {
    public static void main(String[] args) {

        Rover viper = new Rover();
        System.out.println("viper is actually " + viper.getLocation());
        System.out.println(viper.getPosition());
        System.out.println(viper.getDirection());
        System.out.println(viper.toString());
        System.out.println("---------------------------");

        Rover python = new Rover(new Position(5,10), Direction.EAST, "Python");
        System.out.println("Python is actually " + python.getLocation());
        System.out.println(python.getPosition());
        System.out.println(python.getDirection());
        System.out.println(python.toString());
        System.out.println("---------------------------");

        Rover anaconda = new Rover(20,30, Direction.EAST, "Anaconda");
        System.out.println("anaconda is actually " + anaconda.getLocation());
        System.out.println(anaconda.getPosition());
        System.out.println(anaconda.getDirection());
        System.out.println(anaconda.toString());
        System.out.println("---------------------------");

        //------------------------------------------------------

        System.out.println("---------------------------");
        System.out.println("Test cases about turnRight");
        System.out.println("---------------------------");
        System.out.println("Viper is actually " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());

        System.out.println(".");
        System.out.println(".");


        System.out.println("---------------------------");
        System.out.println("Test cases about turnLeft");
        System.out.println("---------------------------");
        System.out.println("Viper is actually " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());

        System.out.println(".");
        System.out.println(".");

        System.out.println("---------------------------");
        System.out.println("Test cases about move and turnRight");
        System.out.println("---------------------------");
        System.out.println("viper is actually " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving twice");
        viper.move();
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving once");
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving twice");
        viper.move();
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning right");
        viper.turnRight();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving once");
        viper.move();
        System.out.println("now " + viper.getLocation());

        System.out.println(".");
        System.out.println(".");

        System.out.println("---------------------------");
        System.out.println("Test cases about move and turnLeft");
        System.out.println("---------------------------");
        System.out.println("viper is actually " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving twice");
        viper.move();
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving once");
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving twice");
        viper.move();
        viper.move();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is turning left");
        viper.turnLeft();
        System.out.println("now " + viper.getLocation());
        System.out.println("Viper is moving once");
        viper.move();
        System.out.println("now " + viper.getLocation());


    }
}
