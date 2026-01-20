<?php

namespace App\R301\Controller;

use App\R301\Model\PostLike;
use App\R301\Model\Post;
use App\R301\Model\Notification;
use App\R301\Model\User;

class LikesController
{
    public function toggleLike()
    {
        header('Content-Type: application/json');
        
        if (!isset($_SESSION['id'])) {
            http_response_code(401);
            echo json_encode(['error' => 'Non authentifié']);
            exit;
        }

        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!isset($data['post_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Post ID manquant']);
            exit;
        }

        $post_id = $data['post_id'];
        $utilisateur_id = $_SESSION['id'];

        $postLikeModel = new PostLike();

        $existingLike = $postLikeModel->findBy([
            'post_id' => $post_id,
            'utilisateur_id' => $utilisateur_id
        ]);

        if (!empty($existingLike)) {
            $postLikeModel->deleteByPostAndUser($post_id, $utilisateur_id);
            $liked = false;
        } else {
            $date_like = date('Y-m-d H:i:s');
            $postLikeModel->add($post_id, $utilisateur_id, $date_like);
            $liked = true;
            
            $postModel = new Post();
            $post = $postModel->find($post_id);
            
            if ($post && $post['utilisateur_id'] != $utilisateur_id) {
                $notificationModel = new Notification();
                $userModel = new User();
                $auteur = $userModel->find($utilisateur_id);
                $auteurNom = $auteur['nom'] ?? 'Quelqu\'un';
                
                $message = "$auteurNom a aimé votre publication";
                $notificationModel->add($post['utilisateur_id'], $message, 0, $date_like);
            }
        }

        $allLikes = $postLikeModel->findBy(['post_id' => $post_id]);
        $likeCount = count($allLikes);

        echo json_encode([
            'success' => true,
            'liked' => $liked,
            'likeCount' => $likeCount
        ]);
        exit;
    }

    public function getLikeCount()
    {
        header('Content-Type: application/json');
        
        if (!isset($_GET['post_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Post ID manquant']);
            exit;
        }

        $post_id = $_GET['post_id'];
        $postLikeModel = new PostLike();
        $likes = $postLikeModel->findBy(['post_id' => $post_id]);
        $likeCount = count($likes);

        $isLiked = false;
        if (isset($_SESSION['id'])) {
            $userLikes = $postLikeModel->findBy([
                'post_id' => $post_id,
                'utilisateur_id' => $_SESSION['id']
            ]);
            $isLiked = !empty($userLikes);
        }

        echo json_encode([
            'likeCount' => $likeCount,
            'isLiked' => $isLiked
        ]);
        exit;
    }
}
