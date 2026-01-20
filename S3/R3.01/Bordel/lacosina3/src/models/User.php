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

  public function add($identifiant, $password, $mail)
  {

    $query = "INSERT INTO users (identifiant, password, mail)
    VALUES (:identifiant, :password, :mail)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':identifiant', $identifiant);
    $stmt->bindParam(':password', $password);
    $stmt->bindParam(':mail', $mail);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $identifiant, $password, $mail)
  {
    $stmt = $this->conn->prepare("SELECT image FROM users WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $oldImage = $stmt->fetchColumn();

    $query = "UPDATE users 
              SET identifiant = :identifiant, password = :password, mail = :mail
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':identifiant', $identifiant);
    $stmt->bindParam(':password', $password);
    $stmt->bindParam(':mail', $mail);

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
}
