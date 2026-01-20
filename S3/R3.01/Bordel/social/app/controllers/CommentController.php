<?php

namespace App\R301\Controller;
use App\R301\Model\Comment;
use App\R301\Model\Post;
use App\R301\Model\Notification;
use App\R301\Model\User;

class CommentController
{

  private $commentModel;
  public function __construct()
  {
    $this->commentModel = new Comment();
  }

  public function ajouter()
  {
    if (!isset($_SESSION['id'])) {
      if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
        header('Content-Type: application/json');
        echo json_encode(['success' => false, 'message' => 'Vous devez être connecté']);
      } else {
        echo "Erreur: vous devez être connecté pour ajouter un commentaire.";
      }
      return;
    }

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
      $post_id = $_POST['post_id'] ?? null;
      $contenu = $_POST['contenu'] ?? null;
      $utilisateur_id = $_SESSION['id'];
      $date_publication = date('Y-m-d H:i:s');

        if ($post_id && $contenu) {
          $comment_id = $this->commentModel->add($contenu, $utilisateur_id, $post_id, $date_publication);
          if ($comment_id) {
            $postModel = new Post();
          $post = $postModel->find($post_id);
          
          if ($post && $post['utilisateur_id'] != $utilisateur_id) {
            $notificationModel = new Notification();
            $userModel = new User();
            $auteur = $userModel->find($utilisateur_id);
            $auteurNom = $auteur['nom'] ?? 'Quelqu\'un';
            
            $message = "$auteurNom a commenté votre publication";
            $lien = "?c=post&a=detail&id=$post_id";
            $notificationModel->add($post['utilisateur_id'], $message, 0, $date_publication);
          }
          
          if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            $comment = $this->commentModel->find($comment_id);
            $user = new User();
            $auteur = $user->find($utilisateur_id);
            
            header('Content-Type: application/json');
            echo json_encode([
              'success' => true,
              'comment' => [
                'id' => $comment_id,
                'contenu' => $contenu,
                'auteur' => $auteur['nom'] ?? 'Anonyme',
                'date_commentaire' => $date_publication,
                'utilisateur_id' => $utilisateur_id
              ]
            ]);
          } else {
            header('Location: ?c=post&a=detail&id=' . $post_id);
            exit;
          }
        } else {
          $response = ['success' => false, 'message' => 'Erreur lors de l\'ajout du commentaire'];
          if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
            header('Content-Type: application/json');
            echo json_encode($response);
          } else {
            echo $response['message'];
          }
        }
      } else {
        $response = ['success' => false, 'message' => 'Données manquantes'];
        if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] === 'XMLHttpRequest') {
          header('Content-Type: application/json');
          echo json_encode($response);
        } else {
          echo $response['message'];
        }
      }
    }
  }

  public function supprimer()
  {
    if (!isset($_GET['id']) || !isset($_SESSION['id'])) {
      echo "Erreur: accès non autorisé.";
      return;
    }

    $id = $_GET['id'];
    $comment = $this->commentModel->find($id);

    if (!$comment) {
      echo "Erreur: le commentaire n'existe pas.";
      return;
    }

    if ($comment['utilisateur_id'] != $_SESSION['id']) {
      echo "Erreur: vous ne pouvez pas supprimer ce commentaire.";
      return;
    }

    $post_id = $comment['post_id'];
    if ($this->commentModel->delete($id)) {
      header('Location: ?c=post&a=detail&id=' . $post_id);
      exit;
    } else {
      echo "Erreur lors de la suppression du commentaire.";
    }
  }

  public function modifier()
  {
    header('Content-Type: application/json');
    
    if (!isset($_SESSION['id'])) {
      http_response_code(401);
      echo json_encode(['error' => 'Non authentifié']);
      exit;
    }

    $data = json_decode(file_get_contents("php://input"), true);
    
    if (!isset($data['comment_id']) || !isset($data['contenu'])) {
      http_response_code(400);
      echo json_encode(['error' => 'Données manquantes']);
      exit;
    }

    $comment_id = $data['comment_id'];
    $nouveau_contenu = trim($data['contenu']);
    $utilisateur_id = $_SESSION['id'];

    if (empty($nouveau_contenu)) {
      http_response_code(400);
      echo json_encode(['error' => 'Le contenu ne peut pas être vide']);
      exit;
    }

    $comment = $this->commentModel->find($comment_id);
    
    if (!$comment) {
      http_response_code(404);
      echo json_encode(['error' => 'Commentaire introuvable']);
      exit;
    }

    if ($comment['utilisateur_id'] != $utilisateur_id) {
      http_response_code(403);
      echo json_encode(['error' => 'Vous ne pouvez pas modifier ce commentaire']);
      exit;
    }

    $success = $this->commentModel->update(
      $comment_id,
      $nouveau_contenu,
      $comment['utilisateur_id'],
      $comment['post_id'],
      $comment['date_commentaire']
    );

    if ($success) {
      echo json_encode([
        'success' => true,
        'contenu' => $nouveau_contenu,
        'message' => 'Commentaire modifié avec succès'
      ]);
    } else {
      http_response_code(500);
      echo json_encode(['error' => 'Erreur lors de la modification']);
    }
    exit;
  }
}
