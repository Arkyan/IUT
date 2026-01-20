<?php

namespace App\R301\Model;

class Contact
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM contact ORDER BY date_creation DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function enregistrer($nom, $email, $description)
  {
    $query = "INSERT INTO contact (nom, email, description, date_creation)
    VALUES (:nom, :email, :description, NOW())";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':nom', $nom);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':description', $description);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }
}
