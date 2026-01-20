<?php

namespace App\R301\Model;

class Commentaire
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM comments ORDER BY create_time DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM comments WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM comments WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function removeBy(array $params)
  {
    $query = "DELETE FROM comments WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params))) . "";
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
  }

  public function add($recette_id, $username, $commentaire)
  {
    $query = "INSERT INTO comments (recette_id, pseudo, commentaire)
    VALUES (:recette_id, :pseudo, :commentaire)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':recette_id', $recette_id);
    $stmt->bindParam(':pseudo', $username);
    $stmt->bindParam(':commentaire', $commentaire);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function remove($id)
  {
    if (!isset($id)) {
      return;
    }
    if (!isset($_SESSION['id']) && $_SESSION['isAdmin'] !== true) {
      return;
    }
    $query = "DELETE FROM comments WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
  }
}
