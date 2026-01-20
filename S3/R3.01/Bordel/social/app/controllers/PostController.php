<?php

namespace App\R301\Controller;
use App\R301\Model\Post;
use App\R301\Model\Comment;

class PostController
{
    private $postModel;
    private $commentModel;

    public function __construct()
    {
        $this->postModel = new Post();
        $this->commentModel = new Comment();
    }

    public function ajouter()
    {
        if (!isset($_SESSION['id'])) {
            header('Location: ?c=user&a=connexion');
            exit;
        }
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'post' . DIRECTORY_SEPARATOR . 'create.php');
    }

    public function index()
    {
        $posts = $this->postModel->findAll();
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'post' . DIRECTORY_SEPARATOR . 'index.php');
    }

    public function detail($id)
    {
        $post = $this->postModel->find($id);
        $comments = $this->commentModel->findByPostId($id);
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'post' . DIRECTORY_SEPARATOR . 'detail.php');
    }

    public function modifier($id)
    {
        if (!isset($_SESSION['id'])) {
            header('Location: ?c=user&a=connexion');
            exit;
        }

        $post = $this->postModel->find($id);
        
        if (!$post || $post['utilisateur_id'] != $_SESSION['id']) {
            echo "Erreur: vous ne pouvez pas modifier ce post.";
            return;
        }

        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'post' . DIRECTORY_SEPARATOR . 'edit.php');
    }

    public function enregistrer()
    {
        if (!isset($_SESSION['id'])) {
            header('Location: ?c=user&a=connexion');
            exit;
        }

        $titre = $_POST['titre'];
        $contenu = $_POST['contenu'];
        $utilisateur_id = $_SESSION['id'];
        $date_publication = date('Y-m-d H:i:s');

        if (isset($_GET['id'])) {
            $post = $this->postModel->find($_GET['id']);
            if (!$post || $post['utilisateur_id'] != $_SESSION['id']) {
                echo "Erreur: vous ne pouvez pas modifier ce post.";
                return;
            }
            $ajoutOk = $this->postModel->update($_GET['id'], $titre, $contenu, $utilisateur_id, $date_publication);
        } else {
            $ajoutOk = $this->postModel->add($titre, $contenu, $utilisateur_id, $date_publication);
        }

        if ($ajoutOk) {
            require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'post' . DIRECTORY_SEPARATOR . 'saved.php');
        } else {
            echo "Erreur lors de l'enregistrement du post.";
        }
    }

    public function supprimer()
    {
        if (!isset($_GET['id']) || !isset($_SESSION['id'])) {
            echo "Erreur: accès non autorisé.";
            return;
        }

        $id = $_GET['id'];
        $post = $this->postModel->find($id);

        if ($post['utilisateur_id'] != $_SESSION['id']) {
            echo "Erreur: vous ne pouvez pas supprimer ce post.";
            return;
        }

        if ($this->postModel->delete($id)) {
            header('Location: ?c=post&a=index');
            exit;
        } else {
            echo "Erreur lors de la suppression du post.";
        }
    }


}