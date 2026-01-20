<?php
session_start();

require_once 'src/Models/Database.php';
require_once 'src/Models/User.php';
require_once 'src/Models/Post.php';
require_once 'src/Models/Comment.php';
require_once 'src/Models/Notification.php';

require_once 'src/Controllers/UserController.php';
require_once 'src/Controllers/PostController.php';
require_once 'src/Controllers/AjaxController.php';

use App\Controllers\UserController;
use App\Controllers\PostController;
use App\Controllers\AjaxController;

$page = $_GET['page'] ?? 'home';
$id = $_GET['id'] ?? null;

$userController = new UserController();
$postController = new PostController();

switch ($page) {
    case 'register':
        $userController->register();
        break;
    case 'login':
        $userController->login();
        break;
    case 'logout':
        $userController->logout();
        break;
    case 'create_post':
        $postController->create();
        break;
    case 'edit_post':
        if ($id) $postController->edit($id);
        break;
    case 'delete_post':
        if ($id) $postController->delete($id);
        break;
    case 'home':
    default:
        $postController->index();
        break;
    case 'ajax':
        $controller = new AjaxController();
        $controller->handle();
        break;
    case 'profile':
        $userController = new UserController();
        $userController->profile();
        break;
}