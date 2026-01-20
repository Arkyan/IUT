<?php

namespace App\R301\Model;

class Notification
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM notifications ORDER BY date_notification DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function findByUserId($utilisateur_id, $limit = 10)
  {
    $query = "SELECT * FROM notifications WHERE utilisateur_id = :utilisateur_id ORDER BY date_notification DESC LIMIT :limit";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function findUnreadByUserId($utilisateur_id)
  {
    $query = "SELECT * FROM notifications WHERE utilisateur_id = :utilisateur_id AND isRead = 0 ORDER BY date_notification DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function countUnreadByUserId($utilisateur_id)
  {
    $query = "SELECT COUNT(*) as count FROM notifications WHERE utilisateur_id = :utilisateur_id AND isRead = 0";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->execute();
    $result = $stmt->fetch(\PDO::FETCH_ASSOC);
    return $result['count'];
  }

  public function find($id)
  {
    $query = "SELECT * FROM notifications WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM notifications WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($utilisateur_id, $message, $isRead, $date_notification)
  {
    $utilisateur_id = (int)$utilisateur_id;
    $isRead = (int)$isRead;
    $message = (string)$message;
    
    $query = "INSERT INTO notifications (utilisateur_id, message, isRead, date_notification)
    VALUES (:utilisateur_id, :message, :isRead, :date_notification)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id, \PDO::PARAM_INT);
    $stmt->bindParam(':message', $message, \PDO::PARAM_STR);
    $stmt->bindParam(':isRead', $isRead, \PDO::PARAM_INT);
    $stmt->bindParam(':date_notification', $date_notification, \PDO::PARAM_STR);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $utilisateur_id, $message, $isRead, $date_notification)
  {

    $query = "UPDATE notifications 
              SET utilisateur_id = :utilisateur_id, message = :message, isRead = :isRead, date_notification = :date_notification
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':message', $message);
    $stmt->bindParam(':isRead', $isRead);
    $stmt->bindParam(':date_notification', $date_notification);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM notifications WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function markAsRead($id)
  {
    $query = "UPDATE notifications SET isRead = 1 WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    return $stmt->execute();
  }

  public function markAllAsReadByUserId($utilisateur_id)
  {
    $query = "UPDATE notifications SET isRead = 1 WHERE utilisateur_id = :utilisateur_id AND isRead = 0";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    return $stmt->execute();
  }
}
