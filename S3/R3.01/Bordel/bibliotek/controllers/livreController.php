<?php
require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'models' . DIRECTORY_SEPARATOR . 'Livre.php';

class livreController
{
    private $livreModel;

    public function __construct()
    {
        $this->livreModel = new Livre();
    }

    public function index()
    {
        $livres = $this->livreModel->obtenirLivres();
        require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'livres' . DIRECTORY_SEPARATOR . 'index.php';
    }

    public function ajouter()
    {
        require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'livres' . DIRECTORY_SEPARATOR . 'new.php';
    }

    public function enregistrer()
    {
        $titre = isset($_POST['titre']) ? trim($_POST['titre']) : '';
        $auteur = isset($_POST['auteur']) ? trim($_POST['auteur']) : '';
        $categorie = isset($_POST['categorie']) ? trim($_POST['categorie']) : '';
        $annee = isset($_POST['annee_publication']) ? trim($_POST['annee_publication']) : null;
        $isbn = isset($_POST['isbn']) ? trim($_POST['isbn']) : '';

        if ($titre === '' || $auteur === '' || $categorie === '' || $annee === null || $isbn === '') {
            echo "Tous les champs sont requis.";
            return;
        }

        $newId = $this->livreModel->ajouterLivre($titre, $auteur, $categorie, $annee, $isbn);
        if ($newId) {
            header('Location: ?c=livre&a=index');
            exit;
        }
        echo "Erreur lors de l'ajout du livre.";
    }

    public function detail()
    {
        $id = isset($_GET['id']) ? $_GET['id'] : null;
        if ($id && is_numeric($id)) {
            $livre = $this->livreModel->trouver($id);
            require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'livres' . DIRECTORY_SEPARATOR . 'detail.php';
            return;
        }
        echo "ID invalide pour le détail du livre.";
    }

    public function supprimer()
    {
        $id = isset($_GET['id']) ? $_GET['id'] : null;
        if ($id && is_numeric($id)) {
            $this->livreModel->supprimerLivre($id);
            header('Location: ?c=livre&a=index');
            exit;
        }
        echo "ID invalide pour suppression.";
    }
}
