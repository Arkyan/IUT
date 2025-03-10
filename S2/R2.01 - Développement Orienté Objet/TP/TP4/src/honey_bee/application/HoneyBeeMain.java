package honey_bee.application;
import honey_bee.gui.Console;
import honey_bee.model.*;
import java.util.Arrays;
import java.util.List;

public class HoneyBeeMain {

    public static void main(String[] args) {
        someHoneyBees();
        arrayOfHoneyBees();
        collectionOfHoneyBees();
    }

    private static void someHoneyBees() {
        Console.title("Some honeybees");

        HoneyBee queen = new Queen("Mellifera");
        HoneyBee firstWorker = new Worker("Maya");
        HoneyBee secondWorker = new Worker("Marguerite");
        HoneyBee thirdWorker = new Worker("Propolis");
        HoneyBee firstDrone = new Drone("Willy");
        HoneyBee secondDrone = new Drone("Didier(");

        Console.message(queen.doYourJob());
        Console.message(firstWorker.doYourJob());
        Console.message(secondWorker.doYourJob());
        Console.message(thirdWorker.doYourJob());
        Console.message(firstDrone.doYourJob());
        Console.message(secondDrone.doYourJob());

        Console.message(Console.SEPARATOR_LINE);

        Console.message(queen.fly());
        Console.message(firstWorker.fly());
        Console.message(secondWorker.fly());
        Console.message(thirdWorker.fly());
        Console.message(firstDrone.fly());
        Console.message(secondDrone.fly());
    }

    private static void arrayOfHoneyBees(){
        Console.title("Array of honeybees");
        HoneyBee[] honeyBees = {
                new Queen("Mellifera"),
                new Worker("Maya"),
                new Worker("Marguerite"),
                new Worker("Propolis"),
                new Drone("Willy"),
                new Drone("Didier")
        };

        for (HoneyBee honeyBee : honeyBees) {
            Console.message(honeyBee.doYourJob());
        }

        Console.message(Console.SEPARATOR_LINE);

        for (HoneyBee honeyBee : honeyBees) {
            Console.message(honeyBee.fly());
        }
    }


    private static void collectionOfHoneyBees(){
        /*
        Console.title("Collection of honeybees");
        ArrayList<HoneyBee> honeyBees = new ArrayList<>();
        honeyBees.add(new Queen("Mellifera"));
        honeyBees.add(new Worker("Maya"));
        honeyBees.add(new Worker("Marguerite"));
        honeyBees.add(new Worker("Propolis"));
        honeyBees.add(new Drone("Willy"));
        honeyBees.add(new Drone("Didier"));

        for (HoneyBee honeyBee : honeyBees) {
            Console.message(Console.SEPARATOR_LINE);
            Console.message(honeyBee.doYourJob());
            Console.message(honeyBee.fly());
        }
        */

        Console.title("Collection of honeybees");
        List<HoneyBee> honeyBees = Arrays.asList(
            new Queen("Mellifera"),
            new Worker("Maya"),
            new Worker("Marguerite"),
            new Worker("Propolis"),
            new Drone("Willy"),
            new Drone("Didier")
        );

        for (HoneyBee honeyBee : honeyBees) {
            Console.message(Console.SEPARATOR_LINE);
            Console.message(honeyBee.doYourJob());
            Console.message(honeyBee.fly());
        }

        Console.title("My collection has 6 honeybees");
        int queenCount = 0;
        int workerCount = 0;
        int droneCount = 0;

        for (HoneyBee honeyBee : honeyBees) {
            if (honeyBee instanceof Queen) {
                queenCount++;
            } else if (honeyBee instanceof Worker) {
                workerCount++;
            } else if (honeyBee instanceof Drone) {
                droneCount++;
            }
        }

        Console.message("My collection has " + queenCount + " queen");
        Console.message("My collection has " + workerCount + " workers");
        Console.message("My collection has " + droneCount + " drones");
    }
}