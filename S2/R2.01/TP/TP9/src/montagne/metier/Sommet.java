package montagne.metier;

public class Sommet implements Comparable<Sommet> {
    private final String nom;
    private final Integer altitude;
    private final ChaineDeMontagne chaine;

    public Sommet(String nom, Integer altitude, ChaineDeMontagne chaine) {
        this.nom = nom;
        this.altitude = altitude;
        this.chaine = chaine;
    }

    public String nom() {
        return nom;
    }

    public Integer altitude() {
        return altitude;
    }

    public ChaineDeMontagne chaine() {
        return chaine;
    }

    public String description() {
        return nom + " (" + altitude + "m)" + " de la chaine --> " + chaine.getNom();
    }

    @Override
    public int compareTo(Sommet autresommet) {
        return autresommet.altitude.compareTo(this.altitude);
    }
    
    
}
