<?php
session_start();

require 'vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Handler\FirePHPHandler;
use App\R301\Controller\RecetteController;
use App\R301\Controller\ContactController;
use App\R301\Controller\FavoriController;
use App\R301\Controller\CommentaireController;
use App\R301\Controller\UserController;

$logger = new Logger('app_log');
$logger->pushHandler(new StreamHandler(__DIR__ . DIRECTORY_SEPARATOR . 'log' . DIRECTORY_SEPARATOR . 'app.log', Logger::DEBUG));
$logger->pushHandler(new FirePHPHandler());

$controller = isset($_GET['c']) ? $_GET['c'] : 'home';
$action = isset($_GET['a']) ? $_GET['a'] : 'index';

// si l'utilisateur est connecté, on récupère le nombre de recettes à valider pour l'afficher dans le menu admin
$nbRecettesAValider = 0;
if (isset($_SESSION['identifiant']) && isset($_SESSION['isAdmin']) && $_SESSION['isAdmin']) {
  $recetteController = new RecetteController();
  $nbRecettesAValider = $recetteController->compterRecettesNonValidees();
  $commentaireController = new CommentaireController();
  $nbCommentairesAValider = $commentaireController->compterCommentairesNonValides();

  $nbNotifications = $nbRecettesAValider + $nbCommentairesAValider;
}

if (!isset($_GET['x']) && !($controller === 'recette' && $action === 'indexJSON')) {
  require_once __DIR__ . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'header.php';
}

// routage simple
switch ($controller) {
  case 'home':
    require_once __DIR__ . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'home.php';
    break;
  case 'recette':
    $recetteController = new RecetteController();
    switch ($action) {
      case 'index':
        $recetteController->index();
        break;
      case 'indexJSON':
        $recetteController->indexJSON();
        break;
      case 'ajouter':
        $recetteController->ajouter();
        break;
      case 'enregistrer':
        $recetteController->enregistrer();
        break;
      case 'detail':
        $recetteController->detail($_GET['id']);
        break;
      case 'modifier':
        $recetteController->modifier($_GET['id']);
        break;
      case 'aApprouver':
        $recetteController->aApprouver();
        break;
      case 'valider':
        $recetteController->valider($_GET['id']);
        break;
      case 'enCoursValidation':
        $recetteController->nonValidesPourUtilisateur();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'contact':
    $contactController = new ContactController();
    switch ($action) {
      case 'index':
        $contactController->index();
        break;
      case 'ajouter':
        $contactController->ajouter();
        break;
      case 'enregistrer':
        $contactController->enregistrer();
        break;
    }
    break;
  case 'user':
    $userController = new UserController();
    switch ($action) {
      case 'inscription':
        $userController->inscription();
        break;
      case 'inscrire':
        $userController->enregistrer();
        break;
      case 'connexion':
        $userController->connexion();
        break;
      case 'connecter':
        $userController->verifieConnexion();
        break;
      case 'deconnexion':
        $userController->deconnexion();
        break;
      case 'profil':
        $userController->profil();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'favoris':
    $favoriController = new FavoriController();
    switch ($action) {
      case 'afficher':
        $favoriController->index();
        break;
      case 'ajouter':
        $favoriController->ajouter();
        break;
      case 'getFavoris':
        $favoriController->getFavoris($_GET['id']);
        break;
      case 'retirer':
        $favoriController->retirer();
        break;
      case 'toggle':
        $favoriController->addOrRemove();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'commentaire':
    $commentaireController = new CommentaireController();
    switch ($action) {
      case 'ajouter':
        $commentaireController->ajouter($_GET['id_recette']);
        break;
      case 'liste':
        $commentaireController->liste();
        break;
      case 'supprimer':
        $commentaireController->supprimer($_GET['id']);
        break;
      case 'aApprouver':
        $commentaireController->aApprouver();
        break;
      case 'valider':
        $commentaireController->valider($_GET['id']);
        break;
      case 'enCoursValidation':
        $commentaireController->nonValidesPourUtilisateur();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  default:
    $_SESSION['message'] = ['danger' => 'Page non trouvée'];;
    header('Location: ?c=home');
    exit;
}

if (!isset($_GET['x'])) {
  require_once __DIR__ . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . 'Views' .
    DIRECTORY_SEPARATOR . 'footer.php';
}
