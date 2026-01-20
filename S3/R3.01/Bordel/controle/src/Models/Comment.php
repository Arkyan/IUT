<?php
namespace App\Models;

use PDO;

class Comment {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::getConnection();
    }

    public function create($contenu, $userId, $postId) {
        $sql = "INSERT INTO comments (contenu, user_id, post_id) VALUES (:contenu, :uid, :pid)";
        $stmt = $this->pdo->prepare($sql);
        $success = $stmt->execute(['contenu' => $contenu, 'uid' => $userId, 'pid' => $postId]);
        
        if ($success) {
            return $this->pdo->lastInsertId();
        }
        return false;
    }

    public function getByPostId($postId) {
        $sql = "SELECT c.*, u.nom AS user_nom 
                FROM comments c 
                JOIN users u ON c.user_id = u.id 
                WHERE c.post_id = :pid 
                ORDER BY c.created_at ASC";
                
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['pid' => $postId]);
        return $stmt->fetchAll();
    }

    public function getScore($commentId) {
        $sql = "SELECT SUM(CASE WHEN vote_type = 'up' THEN 1 ELSE -1 END) AS score 
                FROM comment_likes WHERE comment_id = :cid";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['cid' => $commentId]);
        $result = $stmt->fetch();
        return $result['score'] ?? 0;
    }

    public function vote($userId, $commentId, $voteType) {
        $sql = "INSERT INTO comment_likes (user_id, comment_id, vote_type) 
                VALUES (:uid, :cid, :vtype)
                ON DUPLICATE KEY UPDATE vote_type = :vtype";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['uid' => $userId, 'cid' => $commentId, 'vtype' => $voteType]);
    }
}