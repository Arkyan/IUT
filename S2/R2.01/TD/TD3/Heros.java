public class Heros extends PersonnageFarWest {
    private String profession;
    private Cheval cheval;

    public Heros(String nom, String prenom, String profession, Cheval cheval){
        super(nom,prenom);
        this.profession = profession;
        this.cheval = cheval;
    }

    public void monter(Cheval cheval){
        //TODO
    }

    public void attraper(Bandit bandit){
        //TODO
    }

    public String decrire() {
        return this.prenom + " " + this.nom + "!" + "Je suis " + this.profession + " mon cheval est " + this.cheval.decrire();
    }
}
