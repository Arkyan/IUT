import java.util.Scanner;

public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");

        Scanner keyboard = new Scanner(System.in);

        System.out.println("What is your name?");
        String name = keyboard.nextLine();

        int groupNumber;
        do {
            System.out.println("What is your group number?");
            groupNumber = keyboard.nextInt();
        } while (groupNumber < 1 || groupNumber > 3);

        System.out.println("Hello, " + name + " from group " + groupNumber + "!");

        keyboard.close();
    }
} 