<?php

namespace App\R301\Controller;

use App\R301\Model\Favori;
use App\R301\Model\Recette;

class FavoriController
{

  private $favoriModel;
  private $recetteModel;
  public function __construct()
  {
    $this->favoriModel = new Favori();
    $this->recetteModel = new Recette();
  }

  function index()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'favoris.php');
  }

  function ajouter()
  {
    if (!isset($_SESSION['id'])) {
      header('Location: ?c=user&a=connexion');
      exit();
    }

    $id_utilisateur = $_SESSION['id'];
    $id_recette = $_GET['id'];
    $ajout = $this->favoriModel->findBy(['user_id' => $id_utilisateur, 'recette_id' => $id_recette]);

    if (count($ajout) > 0) {
      require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php');
    }

    $this->favoriModel->add($id_recette, $id_utilisateur);
    $_SESSION['message'] = ['success' => 'Recette ajoutée aux favoris'];

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php');
  }

  function retirer()
  {
    if (!isset($_SESSION['id'])) {
      header('Location: ?c=user&a=connexion');
      exit();
    }

    $id_utilisateur = $_SESSION['id'];
    $id_recette = $_GET['id'];

    $this->favoriModel->removeBy(['user_id' => $id_utilisateur, 'recette_id' => $id_recette]);
    $_SESSION['message'] = ['success' => 'Recette retirée des favoris'];

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php');
  }

  function exists($id_utilisateur, $id_recette)
  {
    $favori = $this->favoriModel->findBy(['user_id' => $id_utilisateur, 'recette_id' => $id_recette]);
    return count($favori) > 0;
  }

  function getFavoris($id_utilisateur)
  {
    $favoris = $this->favoriModel->findBy(['user_id' => $id_utilisateur]);
    $recettesFavoris = [];
    foreach ($favoris as $favori) {
      $recette = $this->recetteModel->find($favori['recette_id']);
      if ($recette) {
        $recettesFavoris[] = $recette;
      }
    }
    header('Content-Type: application/json');
    echo json_encode($recettesFavoris);
  }

  function addOrRemove()
  {
    $id_utilisateur = $_SESSION['id'];
    $id_recette = $_GET['recette_id'];
    $favoris = $this->favoriModel->findBy(['user_id' => $id_utilisateur, 'recette_id' => $id_recette]);
    if ($favoris) {
      $this->favoriModel->removeBy(['user_id' => $id_utilisateur, 'recette_id' => $id_recette]);
    } else {
      $this->favoriModel->add($id_recette, $id_utilisateur);
    }
    header('Content-Type: application/json');
    echo json_encode(['success' => true]);
  }

  function deleteByRecetteId($id_recette)
  {
    $this->favoriModel->removeBy(['recette_id' => $id_recette]);
  }
}
