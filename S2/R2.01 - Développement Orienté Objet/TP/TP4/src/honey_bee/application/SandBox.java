package honey_bee.application;
import honey_bee.gui.Console;
import honey_bee.model.*;

public class SandBox {
    public static void main(String[] args) {
        HoneyBee melli = new Queen("Mellifera");
        HoneyBee may = new Worker("Maya");
        HoneyBee will = new Drone("Willy");

        Console.title("Appel à GetClass de la classe Object");
        Console.message("Classe de l'objet melli : " + melli.getClass());
        Console.message("Classe de l'objet may : " + may.getClass());
        Console.message("Classe de l'objet will : " + will.getClass());

        Console.title("Appel à GetName de la classe Class via le mot clé class");
        Console.message("Classe d'un objet Class Queen.class : " + (Queen.class).getName());
        Console.message("Classe d'un objet Class Worker.class : " + (Worker.class).getName());
        Console.message("Classe d'un objet Class Drone.class : " + (Drone.class).getName());

        Console.title("Appel à getName de la Classe HoneyBee");
        Console.message("Nom de l'objet melli : " + melli.getName());
        Console.message("Nom de l'objet may : " + may.getName());
        Console.message("Nom de l'objet will : " + will.getName());

        //Compile
        //Queen firstQueen = (Queen) melli;

        //Compile pas
        //Queen nextQueen = (Worker) may;

        Console.title("Operateur instanceof");
        if (melli instanceof HoneyBee)
            Console.message("melli est une instance de HoneyBee");
        if (melli instanceof Queen)
            Console.message("melli est une instance de Queen");
        if (melli instanceof Worker)
            Console.message("melli est une instance de Worker");
        if (melli instanceof Drone)
            Console.message("melli est une instance de Drone");

    }
}
