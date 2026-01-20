<?php
require_once __DIR__ . DIRECTORY_SEPARATOR . 'controllers' . DIRECTORY_SEPARATOR . 'livreController.php';
require_once __DIR__ . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'header.php';

$controller = isset($_GET['c']) ? $_GET['c'] : 'home';
$action = isset($_GET['a']) ? $_GET['a'] : 'index';

switch ($controller) {
    case 'home':
        require_once __DIR__ . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'accueil.php';
        break;

    case 'livre':
        $livreController = new livreController();
        switch ($action) {
            case 'index':
                $livreController->index();
                break;
            case 'ajouter':
                $livreController->ajouter();
                break;
            case 'enregistrer':
                $livreController->enregistrer();
                break;
            case 'supprimer':
                $livreController->supprimer();
                break;
            case 'detail':
                $livreController->detail();
                break;
            default:
                echo "Action non reconnue.";
                break;
        }
        break;
}

require_once __DIR__ . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'footer.php';