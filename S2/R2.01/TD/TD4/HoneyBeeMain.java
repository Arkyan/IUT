public class HoneyBeeMain {

    public static void main(String[] args) {

        System.out.println("--------------------------------------------");
        System.out.println(" Some honeybees ");
        System.out.println("--------------------------------------------");

        HoneyBee queen = new Queen();
        HoneyBee firstWorker = new HoneyBee();
        HoneyBee secondWorker = new Worker();
        HoneyBee thirdWorker = new Worker();
        HoneyBee firstDrone = new HoneyBee();
        HoneyBee secondDrone = new Drone();

        System.out.println(queen.doYourJob());
        System.out.println(firstWorker.doYourJob());
        System.out.println(secondWorker.doYourJob());
        System.out.println(thirdWorker.doYourJob());
        System.out.println(firstDrone.doYourJob());
        System.out.println(secondDrone.doYourJob());

        System.out.println("--------------------------------------------");

        System.out.println(queen.fly());
        System.out.println(firstWorker.fly());
        System.out.println(secondWorker.fly());
        System.out.println(thirdWorker.fly());
        System.out.println(firstDrone.fly());
        System.out.println(secondDrone.fly());

    }

}
