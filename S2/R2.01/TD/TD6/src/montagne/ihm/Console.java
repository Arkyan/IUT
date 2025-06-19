package montagne.ihm;

public class Console {
    public static final String LIGNE_HORIZONTALE = "----------------------------------------";

    public static void message(String texte) {
        System.out.println(texte);
    }

    public static void titre(String texte) {
        System.out.println(LIGNE_HORIZONTALE);
        System.out.println(texte);
        System.out.println(LIGNE_HORIZONTALE);
    }
}
