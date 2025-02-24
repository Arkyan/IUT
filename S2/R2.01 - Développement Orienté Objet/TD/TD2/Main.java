public class Main {
    public static void main(String[] args) {
    Device babbageMachine = new Device("Babbage Analytical Machine", 1837);
    ComputerPioneer adaLovelace = new ComputerPioneer("Lovelace", "Ada", babbageMachine);

    Device turingEngine = new Device("Turing Engine", 1936);
    ComputerPioneer alanTuring = new ComputerPioneer("Turing", "Alan", turingEngine);

    System.out.println(adaLovelace.toString());
    System.out.println(alanTuring.toString());

    System.out.println("TEST CASE 3");
    System.out.println("--------------------");
    System.out.println(adaLovelace.worksOn(babbageMachine));
    System.out.println(adaLovelace.worksOn(turingEngine));
    System.out.println(alanTuring.worksOn(babbageMachine));
    System.out.println(alanTuring.worksOn(turingEngine));
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

    System.out.println("-----------------------");
    System.out.println(babbageMachine.toString() + adaLovelace.toString() + " who worked on it");
    System.out.println(turingEngine.toString() + alanTuring.toString() + " who worked on it");
    }
}