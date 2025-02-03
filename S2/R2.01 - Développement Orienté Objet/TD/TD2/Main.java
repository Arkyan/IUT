public class Main {
    public static void main(String[] args) {
    Device BabbageMachine = new Device("Babbage Analytical Machine", 1837);
    ComputerPioneer adaLovelace = new ComputerPioneer("Lovelace", "Ada", BabbageMachine);

    Device TuringEngine = new Device("Turing Engine", 1936);
    ComputerPioneer alanTuring = new ComputerPioneer("Turing", "Alan", TuringEngine);

    System.out.println(adaLovelace.toString());
    System.out.println(alanTuring.toString());

    System.out.println("TEST CASE 3");
    System.out.println("--------------------");
    System.out.println(adaLovelace.worksOn(BabbageMachine));
    System.out.println(adaLovelace.worksOn(TuringEngine));
    System.out.println(alanTuring.worksOn(BabbageMachine));
    System.out.println(alanTuring.worksOn(TuringEngine));
    System.out.println("--------------------");

    System.out.println("TEST CASE 4");
    System.out.println("--------------------");
    Device babbage = new Device("Babbage Analytical Machine", 1837);
    Device turing = new Device("Turing Engine", 1936);
    System.out.println(adaLovelace.worksOn(babbage));
    System.out.println(adaLovelace.worksOn(turing));
    System.out.println(alanTuring.worksOn(babbage));
    System.out.println(alanTuring.worksOn(turing));
    System.out.println("--------------------");
    }
}