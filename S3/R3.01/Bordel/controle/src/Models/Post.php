<?php
namespace App\Models;

use PDO;

class Post {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::getConnection();
    }

    public function getAll() {
        $sql = "SELECT posts.*, users.nom as auteur 
                FROM posts 
                JOIN users ON posts.utilisateur_id = users.id 
                ORDER BY date_publication DESC";
        return $this->pdo->query($sql)->fetchAll();
    }

    public function create($titre, $contenu, $userId, $image = null) {
        $sql = "INSERT INTO posts (titre, contenu, utilisateur_id) VALUES (:titre, :contenu, :uid)";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute([
            'titre' => $titre, 
            'contenu' => $contenu, 
            'uid' => $userId,
        ]);
    }

    public function find($id) {
        $stmt = $this->pdo->prepare("SELECT * FROM posts WHERE id = :id");
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    }

    public function update($id, $titre, $contenu) {
        $sql = "UPDATE posts SET titre = :titre, contenu = :contenu WHERE id = :id";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['titre' => $titre, 'contenu' => $contenu, 'id' => $id]);
    }

    public function delete($id) {
        $stmt = $this->pdo->prepare("DELETE FROM posts WHERE id = :id");
        return $stmt->execute(['id' => $id]);
    }

    public function getLikeCount($postId) {
        $stmt = $this->pdo->prepare("SELECT COUNT(*) AS count FROM post_likes WHERE post_id = ?");
        $stmt->execute([$postId]);
        $res = $stmt->fetch();
        return $res['count'] ?? 0;
    }

    public function hasUserLiked($postId, $userId) {
        $stmt = $this->pdo->prepare("SELECT COUNT(*) FROM post_likes WHERE post_id = ? AND user_id = ?");
        $stmt->execute([$postId, $userId]);
        return $stmt->fetchColumn() > 0;
    }
}