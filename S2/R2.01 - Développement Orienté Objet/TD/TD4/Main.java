public class Main {
    public static void main(String[] args) {
        HoneyBee queen = new Queen("Mellifera");
        HoneyBee firstWorker = new Worker("Maya");
        HoneyBee secondWorker = new Worker("Marguerite");
        HoneyBee thirdWorker = new Worker("Propolis");
        HoneyBee firstDrone = new Drone("Willy");
        HoneyBee secondDrone = new Drone("Didier");

        System.out.println(queen.doYourJob());
        System.out.println(firstWorker.doYourJob());
        System.out.println(secondWorker.doYourJob());
        System.out.println(thirdWorker.doYourJob());
        System.out.println(firstDrone.doYourJob());
        System.out.println(secondDrone.doYourJob());

        System.out.println("----------------------");

        System.out.println(queen.fly());
        System.out.println(firstWorker.fly());
        System.out.println(secondWorker.fly());
        System.out.println(thirdWorker.fly());
        System.out.println(firstDrone.fly());
        System.out.println(secondDrone.fly());
    }
}
