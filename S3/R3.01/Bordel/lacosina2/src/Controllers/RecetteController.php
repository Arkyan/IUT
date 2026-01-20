<?php

namespace App\R301\Controller;

use App\R301\Model\Recette;
use App\R301\Model\Commentaire;
use App\R301\Model\Favori;

class RecetteController
{

  private $recetteModel;
  private $commentaireModel;
  public function __construct()
  {
    $this->recetteModel = new Recette();
    $this->commentaireModel = new Commentaire();
  }

  function ajouter()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'ajout.php');
  }

  function enregistrer()
  {
    if (!isset($_SESSION['id'])) {
      header('Location: ?c=user&a=connexion');
      exit();
    }

    $title = $_POST['title'];
    $description = $_POST['description'];
    $auteur = $_POST['auteur'];
    $image = $_FILES['image'];
    $type_plat = $_POST['type_plat'];

    if (isset($_GET['id'])) {
      $ajoutOk = $this->recetteModel->update($_GET['id'], $title, $description, $auteur, $image, $type_plat);
    } else {
      $ajoutOk = $this->recetteModel->add($title, $description, $auteur, $image, $type_plat);
    }
    if ($ajoutOk) {
      require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php');
    } else {
      echo "Erreur lors de l'enregistrement de la recette.";
    }
  }

  function index()
  {
    // Récupérer le filtre depuis GET
    $filtre = isset($_GET['filtre']) ? $_GET['filtre'] : 'all';

    // Récupérer les recettes selon le filtre
    if ($filtre === 'all') {
      $recipes = $this->recetteModel->findAll();
    } else {
      $recipes = $this->recetteModel->findBy(['type_plat' => $filtre]);
    }

    if (count($recipes) > 0 && isset($_SESSION['id'])) {
      foreach ($recipes as &$recipe) {
        $favoriModel = new Favori();
        $recipe['is_favorite'] = $favoriModel->exists($_SESSION['id'], $recipe['id']);
      }
      unset($recipe);
    }

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'liste.php');
  }

  function indexJSON()
  {
    $recipes = $this->recetteModel->findAll();
    header('Content-Type: application/json');
    echo json_encode($recipes);
  }

  function detail($id)
  {
    $recipe = $this->recetteModel->find($id);
    $favoriModel = new Favori();
    if (isset($_SESSION['id'])) {
      $isFavori = $favoriModel->exists($_SESSION['id'], $id);
    }
    $comments = $this->commentaireModel->findBy(['recette_id' => $id]);
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'detail.php');
  }

  function modifier($id)
  {
    $recipe = $this->recetteModel->find($id);
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'modif.php');
  }
}
