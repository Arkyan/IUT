<?php

namespace App\R301\Model;

class Favori
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM favoris";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM favoris WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM favoris WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($recette_id, $user_id)
  {

    $query = "INSERT INTO favoris (recette_id, user_id)
    VALUES (:recette_id, :user_id)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':recette_id', $recette_id);
    $stmt->bindParam(':user_id', $user_id);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function removeBy(array $params)
  {
    $query = "DELETE FROM favoris WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function update($id, $recette_id, $user_id)
  {
    $stmt = $this->conn->prepare("SELECT image FROM favoris WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $oldImage = $stmt->fetchColumn();

    $query = "UPDATE favoris
              SET recette_id = :recette_id, user_id = :user_id
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':recette_id', $recette_id);
    $stmt->bindParam(':user_id', $user_id);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM favoris WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function exists($user_id, $recette_id)
  {
    $result = $this->findBy(['user_id' => $user_id, 'recette_id' => $recette_id]);
    return count($result) > 0;
  }
}
