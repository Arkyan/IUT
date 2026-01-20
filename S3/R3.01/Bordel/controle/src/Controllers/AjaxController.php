<?php
namespace App\Controllers;

use App\Models\Database;
use App\Models\Comment;
use App\Models\Post;
use App\Models\Notification;

class AjaxController {

    public function handle() {
        header('Content-Type: application/json');
        
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }

        if (!isset($_SESSION['user_id'])) {
            echo json_encode(['status' => 'error', 'message' => 'Non connecté']);
            exit;
        }

        $action = $_GET['action'] ?? '';

        switch ($action) {
            case 'add_comment':
                $this->addComment();
                break;
            case 'like_post':
                $this->likePost();
                break;
            case 'search':
                $this->search();
                break;
            case 'get_notifications':
                $this->getNotifications();
                break;
            case 'mark_notifications_read':
                $this->markNotificationsRead();
                break;
            case 'vote_comment':
                $this->voteComment();
                break;
            case 'edit_comment':
                $this->editComment();
                break;
            default:
                echo json_encode(['status' => 'error', 'message' => 'Action inconnue']);
        }
    }

    private function addComment() {
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($data['contenu']) || !isset($data['post_id'])) {
            echo json_encode(['status' => 'error', 'message' => 'Données manquantes']);
            return;
        }

        $commentModel = new Comment();
        $newId = $commentModel->create($data['contenu'], $_SESSION['user_id'], $data['post_id']);

        if ($newId) {
            $postModel = new Post();
            $post = $postModel->find($data['post_id']);
            
            // Si le post existe et que ce n'est pas mon propre post
            if ($post && $post['utilisateur_id'] != $_SESSION['user_id']) {
                $notifModel = new Notification();
                $msg = ($_SESSION['user_nom'] ?? 'Un utilisateur') . " a commenté votre publication.";
                $notifModel->create($post['utilisateur_id'], $msg);
            }

            echo json_encode([
                'status' => 'success', 
                'user' => $_SESSION['user_nom'] ?? 'Moi',
                'date' => date('d/m H:i'),
                'comment_id' => $newId
            ]);
        } else {
            echo json_encode(['status' => 'error']);
        }
    }

    private function likePost() {
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($data['post_id'])) {
            echo json_encode(['status' => 'error']); 
            return;
        }

        $postId = $data['post_id'];
        $userId = $_SESSION['user_id'];

        $pdo = Database::getConnection();
        
        $stmt = $pdo->prepare("SELECT id FROM post_likes WHERE user_id = ? AND post_id = ?");
        $stmt->execute([$userId, $postId]);
        
        if ($stmt->fetch()) {
            $del = $pdo->prepare("DELETE FROM post_likes WHERE user_id = ? AND post_id = ?");
            $del->execute([$userId, $postId]);
            echo json_encode(['status' => 'unliked']);
        } else {
            $ins = $pdo->prepare("INSERT INTO post_likes (user_id, post_id) VALUES (?, ?)");
            $ins->execute([$userId, $postId]);
            $postModel = new Post();
            $post = $postModel->find($postId);
            
            if ($post && $post['utilisateur_id'] != $userId) {
                $notifModel = new Notification();
                $msg = ($_SESSION['user_nom'] ?? 'Un utilisateur') . " a aimé votre publication.";
                $notifModel->create($post['utilisateur_id'], $msg);
            }

            echo json_encode(['status' => 'liked']);
        }
    }

    private function getNotifications() {
        $notifModel = new Notification();
        $notifs = $notifModel->getUnread($_SESSION['user_id']);
        echo json_encode(['count' => count($notifs), 'items' => $notifs]);
    }

    private function markNotificationsRead() {
        $notifModel = new Notification();
        $success = $notifModel->markAllAsRead($_SESSION['user_id']);
        echo json_encode(['status' => $success ? 'success' : 'error']);
    }

    private function search() {
        $query = $_GET['q'] ?? '';
        
        if (strlen($query) < 2) { 
            echo json_encode([]); 
            return; 
        }
        
        $pdo = Database::getConnection();
        
        $sql = "
            (SELECT id, titre as text, 'post' as type, id as link_id FROM posts WHERE titre LIKE :q)
            UNION 
            (SELECT id, nom as text, 'user' as type, id as link_id FROM users WHERE nom LIKE :q)
            UNION 
            (SELECT id, contenu as text, 'comment' as type, post_id as link_id FROM comments WHERE contenu LIKE :q)
            LIMIT 10
        ";
        
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['q' => "%$query%"]);
        echo json_encode($stmt->fetchAll(\PDO::FETCH_ASSOC));
    }

    private function voteComment() {
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($data['comment_id']) || !isset($data['vote_type'])) {
            echo json_encode(['status' => 'error']);
            return;
        }

        $commentModel = new \App\Models\Comment();
        $commentModel->vote($_SESSION['user_id'], $data['comment_id'], $data['vote_type']);
        
        echo json_encode(['status' => 'success', 'new_score' => $commentModel->getScore($data['comment_id'])]);
    }

    private function editComment() {
        $data = json_decode(file_get_contents('php://input'), true);
        
        if (!isset($data['id']) || !isset($data['contenu'])) {
            echo json_encode(['status' => 'error', 'message' => 'Données manquantes']);
            return;
        }

        $pdo = Database::getConnection();
        
        $stmt = $pdo->prepare("UPDATE comments SET contenu = :contenu WHERE id = :id AND user_id = :uid");
        $success = $stmt->execute([
            'contenu' => $data['contenu'], 
            'id' => $data['id'], 
            'uid' => $_SESSION['user_id']
        ]);
        
        echo json_encode(['status' => $success ? 'success' : 'error']);
    }
}