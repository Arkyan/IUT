public class Bandit extends PersonnageFarWest {
    private Integer taille;
    private Boolean estEnPrison;

    public Bandit(String prenom, String nom, Integer taille){
        super(nom,prenom);
        this.taille = taille;
        this.estEnPrison = false;
    }

    public void faireUnBraquage(){
        //TODO
    }

    public void mettreEnPrison(){
        this.estEnPrison = true;
    }

    public void libererDePrison(){
        this.estEnPrison = false;
    }
}
