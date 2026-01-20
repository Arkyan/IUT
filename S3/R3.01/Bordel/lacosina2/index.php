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
$logger->pushHandler(new StreamHandler(__DIR__. DIRECTORY_SEPARATOR . 'log'.DIRECTORY_SEPARATOR .'app.log', Logger::DEBUG));
$logger->pushHandler(new FirePHPHandler());

$controller = isset($_GET['c']) ? $_GET['c'] : 'home';
$action = isset($_GET['a']) ? $_GET['a'] : 'index';

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
        exit();
        break;
      case 'ajouter':
        if (isset($_SESSION['identifiant'])) $logger->info("l'utilisateur ".$_SESSION['identifiant']. " ajoute une recette");
        $recetteController->ajouter();
        break;
      case 'enregistrer':
        if (isset($_SESSION['identifiant'])) $logger->info("l'utilisateur ".$_SESSION['identifiant']. " enregistre une recette");
        $recetteController->enregistrer();
        break;
      case 'detail':
        $recetteController->detail($_GET['id']);
        break;
      case 'modifier':
        if (isset($_SESSION['identifiant'])) $logger->info("l'utilisateur ".$_SESSION['identifiant']. " modifie une recette");
        $recetteController->modifier($_GET['id']);
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
        if (isset($_POST['identifiant'])) $logger->info("l'utilisateur ".$_POST['identifiant']. " s'est connecté");
        $userController->verifieConnexion();
        break;
      case 'deconnexion':
        if (isset($_SESSION['identifiant'])) $logger->info("l'utilisateur ".$_SESSION['identifiant']. " s'est déconnecté");
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
      default:
        echo "Action non trouvée";
    }
    break;
  default:
    $_SESSION['message'] = ['danger' => 'Page non trouvée'];;
    header('Location: ?c=home');
    exit;
}

// chargement du footer
if (!isset($_GET['x'])) {
  require_once __DIR__ . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR . 'Views' .
    DIRECTORY_SEPARATOR . 'footer.php';
}
