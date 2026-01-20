<?php
namespace App\R301\Controller;

use App\R301\Model\Recette;
use App\R301\Model\Commentaire;
class CommentaireController
{

  private $recetteModel;
  private $commentaireModel;
  public function __construct()
  {
    $this->recetteModel = new Recette();
    $this->commentaireModel = new Commentaire();
  }

  public function ajouter($id_recette)
  {
    $username = $_SESSION['identifiant'] ?? 'Anonyme';
    $contenu = $_POST['commentaire'];

    $this->commentaireModel->add($id_recette, $username, $contenu);
    header("Location: ?c=recette&a=detail&id=$id_recette");
    exit();
  }

  public function liste()
  {
    if (!isset($_SESSION['isAdmin']) || !$_SESSION['isAdmin']) {
      header('Location: ?c=home');
      exit();
    }

    $commentaires = $this->commentaireModel->findAll();

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'commentaire' . DIRECTORY_SEPARATOR . 'liste.php');
  }

  public function supprimer($id)
  {
    if (!isset($_SESSION['isAdmin']) || !$_SESSION['isAdmin']) {
      header('Location: ?c=home');
      exit();
    }

    $this->commentaireModel->remove($id);

    header('Location: ?c=commentaire&a=liste');
    exit();
  }

  public function deleteByRecetteId($id_recette)
  {
    $this->commentaireModel->removeBy(['recette_id' => $id_recette]);
  }
}
