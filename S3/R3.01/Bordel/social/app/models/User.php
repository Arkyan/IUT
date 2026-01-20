<?php

namespace App\R301\Model;

class User
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM users";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM users WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM users WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($nom, $email, $password, $date_inscription)
  {

    $query = "INSERT INTO users (nom, email, password, date_inscription)
    VALUES (:nom, :email, :password, :date_inscription)";
    $stmt = $this->conn->prepare(query: $query);
    $stmt->bindParam(':nom', $nom);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':password', $password);
    $stmt->bindParam(':date_inscription', $date_inscription);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $nom, $email, $password)
  {

    $query = "UPDATE users 
              SET nom = :nom, email = :email, password = :password
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':nom', $nom);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':password', $password);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM users WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function search($query, $limit = 5)
  {
    $searchQuery = "%$query%";
    $sql = "SELECT id, nom, email FROM users WHERE nom LIKE :query OR email LIKE :query LIMIT :limit";
    $stmt = $this->conn->prepare($sql);
    $stmt->bindParam(':query', $searchQuery);
    $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }
}
