<?php
namespace App\Controllers;

use App\Models\Post;
use App\Models\Comment;

class PostController {
    
    public function index() {
        $postModel = new Post();
        $commentModel = new Comment();

        $posts = $postModel->getAll();
        
        $userId = $_SESSION['user_id'] ?? null;

        foreach ($posts as &$post) {
            $post['comments'] = $commentModel->getByPostId($post['id']);
            
            $post['like_count'] = $postModel->getLikeCount($post['id']);
            
            if ($userId) {
                $post['is_liked_by_user'] = $postModel->hasUserLiked($post['id'], $userId);
            } else {
                $post['is_liked_by_user'] = false;
            }
        }
        
        require 'src/Views/post/index.php';
    }

    public function create() {
        $this->checkAuth();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $postModel = new Post();
            $postModel->create($_POST['titre'], $_POST['contenu'], $_SESSION['user_id']);
            header('Location: index.php');
            exit;
        }
        require 'src/Views/post/create.php';
    }

    public function edit($id) {
        $this->checkAuth();

        $postModel = new Post();
        $post = $postModel->find($id);

        if (!$post) {
            die("Ce message n'existe pas.");
        }

        if ($post['utilisateur_id'] != $_SESSION['user_id']) {
            die("⚫ ACCES REFUSE : Vous n'etes pas l'auteur de ce message.");
        }

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $titre = $_POST['titre'];
            $contenu = $_POST['contenu'];

            $postModel->update($id, $titre, $contenu);
            
            header('Location: index.php');
            exit;
        }

        require 'src/Views/post/edit.php';
    }

    public function delete($id) {
        $this->checkAuth();
        $postModel = new Post();
        $post = $postModel->find($id);

        if ($post && $post['utilisateur_id'] == $_SESSION['user_id']) {
            $postModel->delete($id);
        }
        header('Location: index.php');
    }

    private function checkAuth() {
        if (!isset($_SESSION['user_id'])) {
            header('Location: index.php?page=login');
            exit;
        }
    }
}