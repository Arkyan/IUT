<?php

namespace App\R301\Model;

class PostLike
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM post_likes";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM posts WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM post_likes WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($post_id, $utilisateur_id, $date_like)
  {

    $query = "INSERT INTO post_likes (post_id, utilisateur_id, date_like)
    VALUES (:post_id, :utilisateur_id, :date_like)";
    $stmt = $this->conn->prepare(query: $query);
    $stmt->bindParam(':post_id', $post_id);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':date_like', $date_like);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $post_id, $utilisateur_id, $date_like)
  {

    $query = "UPDATE post_likes 
              SET post_id = :post_id, utilisateur_id = :utilisateur_id, date_like = :date_like
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':post_id', $post_id);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':date_like', $date_like);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM post_likes WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function deleteByPostAndUser($post_id, $utilisateur_id)
  {
    $query = "DELETE FROM post_likes WHERE post_id = :post_id AND utilisateur_id = :utilisateur_id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':post_id', $post_id);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }
}
