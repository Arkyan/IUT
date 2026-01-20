<?php   
session_start();

require("vendor/autoload.php");
use App\R301\Controller\PostController;
use App\R301\Controller\CommentController;
use App\R301\Controller\UserController;
use App\R301\Controller\SearchController;
use App\R301\Controller\LikesController;
use App\R301\Controller\VotesController;
use App\R301\Controller\NotificationController;

// Ne pas inclure le header pour les requêtes AJAX
$controller = isset($_GET['c']) ? $_GET['c'] : 'home';
$action = isset($_GET['a']) ? $_GET['a'] : 'index';
$isAjax = isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest';
$isApiRequest = $controller === 'likes' || $controller === 'search' || $controller === 'votes' || $controller === 'notification' ||
                ($controller === 'comment' && $action === 'modifier');

if (!$isAjax && !$isApiRequest) {
    require_once __DIR__ . DIRECTORY_SEPARATOR . 'app' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'header.php';
}

// routage simple
switch ($controller) {
  case 'home':
    require_once __DIR__ . DIRECTORY_SEPARATOR . 'app' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'home.php';
    break;
  case 'post':
    $postController = new PostController();
    switch ($action) {
      case 'index':
        $postController->index();
        break;
      case 'ajouter':
        $postController->ajouter();
        break;
      case 'enregistrer':
        $postController->enregistrer();
        break;
      case 'detail':
        $postController->detail($_GET['id']);
        break;
      case 'modifier':
        $postController->modifier($_GET['id']);
        break;
      case 'supprimer':
        $postController->supprimer();
        break;
      default:
        echo "Action non trouvée";
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
      case 'profile':
        $userController->profile();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'comment':
    $commentController = new CommentController();
    switch ($action) {
      case 'ajouter':
        $commentController->ajouter();
        break;
      case 'modifier':
        $commentController->modifier();
        break;
      case 'supprimer':
        $commentController->supprimer();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'search':
    $searchController = new SearchController();
    switch ($action) {
      case 'liveSearch':
        $searchController->liveSearch();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'likes':
    $likesController = new LikesController();
    switch ($action) {
      case 'toggleLike':
        $likesController->toggleLike();
        break;
      case 'getLikeCount':
        $likesController->getLikeCount();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'votes':
    $votesController = new VotesController();
    switch ($action) {
      case 'toggleVote':
        $votesController->toggleVote();
        break;
      case 'getVoteCount':
        $votesController->getVoteCount();
        break;
      default:
        echo "Action non trouvée";
    }
    break;
  case 'notification':
    $notificationController = new NotificationController();
    switch ($action) {
      case 'getUnreadCount':
        $notificationController->getUnreadCount();
        break;
      case 'getNotifications':
        $notificationController->getNotifications();
        break;
      case 'markAsRead':
        $notificationController->markAsRead();
        break;
      case 'markAllAsRead':
        $notificationController->markAllAsRead();
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

