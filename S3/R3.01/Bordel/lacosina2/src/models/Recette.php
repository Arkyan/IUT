<?php

namespace App\R301\Model;

class Recette
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM recettes";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM recettes WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM recettes WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($titre, $description, $auteur, $image, $type_plat)
  {
    $targetFile = "upload/" . basename($image["name"]);
    move_uploaded_file($image["tmp_name"], $targetFile);
    print_r($targetFile);
    die();

    $query = "INSERT INTO recettes (titre, description, auteur, image, date_creation, type_plat)
    VALUES (:titre, :description, :auteur, :image, NOW(), :type_plat)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':description', $description);
    $stmt->bindParam(':auteur', $auteur);
    $stmt->bindParam(':image', $targetFile);
    $stmt->bindParam(':type_plat', $type_plat);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $titre, $description, $auteur, $image, $type_plat)
  {
    $stmt = $this->conn->prepare("SELECT image FROM recettes WHERE id = :id");
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $oldImage = $stmt->fetchColumn();

    if (!empty($image["name"])) {
      $targetFile = "upload/" . basename($image["name"]);
      move_uploaded_file($image["tmp_name"], $targetFile);

      if ($oldImage && file_exists($oldImage) && $oldImage !== $targetFile) {
        unlink($oldImage);
      }
    } else {
      $targetFile = $oldImage;
    }

    $query = "UPDATE recettes 
              SET titre = :titre, description = :description, auteur = :auteur, image = :image , type_plat = :type_plat
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':description', $description);
    $stmt->bindParam(':auteur', $auteur);
    $stmt->bindParam(':image', $targetFile);
    $stmt->bindParam(':type_plat', $type_plat);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM recettes WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();

    return $stmt->rowCount() > 0;
  }

  public function getComments($id_recette)
  {
    $query = "SELECT * FROM comments WHERE recette_id = :recette_id ORDER BY create_time DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':recette_id', $id_recette);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }
}
