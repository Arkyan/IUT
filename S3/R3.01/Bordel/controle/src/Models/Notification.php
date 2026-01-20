<?php
namespace App\Models;
use PDO;

class Notification {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::getConnection();
    }

    public function create($userId, $message) {
        $sql = "INSERT INTO notifications (user_id, message) VALUES (:uid, :msg)";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['uid' => $userId, 'msg' => $message]);
    }

    public function getUnread($userId) {
        $sql = "SELECT * FROM notifications WHERE user_id = :uid AND lu = 0 ORDER BY created_at DESC";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute(['uid' => $userId]);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function markAllAsRead($userId) {
        $sql = "UPDATE notifications SET lu = 1 WHERE user_id = :uid";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['uid' => $userId]);
    }
}