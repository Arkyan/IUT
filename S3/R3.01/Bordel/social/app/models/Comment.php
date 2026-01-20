<?php

namespace App\R301\Model;

class Comment
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT c.*, u.nom as auteur FROM comments c LEFT JOIN users u ON c.utilisateur_id = u.id ORDER BY c.date_commentaire DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function findByPostId($post_id)
  {
    $query = "SELECT c.*, u.nom as auteur FROM comments c LEFT JOIN users u ON c.utilisateur_id = u.id WHERE c.post_id = :post_id ORDER BY c.date_commentaire DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':post_id', $post_id);
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

  public function add($contenu, $utilisateur_id, $post_id, $date_commentaire)
  {
    $query = "INSERT INTO comments (contenu, utilisateur_id, post_id, date_commentaire)
    VALUES (:contenu, :utilisateur_id, :post_id, :date_commentaire)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':contenu', $contenu);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':post_id', $post_id);
    $stmt->bindParam(':date_commentaire', $date_commentaire);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $contenu, $utilisateur_id, $post_id, $date_commentaire)
  {

    $query = "UPDATE comments 
              SET contenu = :contenu, utilisateur_id = :utilisateur_id, post_id = :post_id, date_commentaire = :date_commentaire
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':contenu', $contenu);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':post_id', $post_id);
    $stmt->bindParam(':date_commentaire', $date_commentaire);
    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM comments WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function search($query, $limit = 5)
  {
    $searchQuery = "%$query%";
    $sql = "SELECT c.id, c.contenu, c.post_id, u.nom as user_name FROM comments c LEFT JOIN users u ON c.utilisateur_id = u.id WHERE c.contenu LIKE :query ORDER BY c.date_commentaire DESC LIMIT :limit";
    $stmt = $this->conn->prepare($sql);
    $stmt->bindParam(':query', $searchQuery);
    $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }
}
