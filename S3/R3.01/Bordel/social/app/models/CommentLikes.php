<?php

namespace App\R301\Model;

class CommentLikes
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT * FROM comment_likes";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT * FROM comment_likes WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM comment_likes WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($utilisateur_id, $comment_id, $vote_type, $date_vote)
  {

    $query = "INSERT INTO comment_likes (utilisateur_id, comment_id, vote_type, date_vote)
    VALUES (:utilisateur_id, :comment_id, :vote_type, :date_vote)";
    $stmt = $this->conn->prepare(query: $query);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':comment_id', $comment_id);
    $stmt->bindParam(':vote_type', $vote_type);
    $stmt->bindParam(':date_vote', $date_vote);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $utilisateur_id, $comment_id, $vote_type, $date_vote)
  {

    $query = "UPDATE comment_likes 
              SET utilisateur_id = :utilisateur_id, comment_id = :comment_id, vote_type = :vote_type, date_vote = :date_vote
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':comment_id', $comment_id);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':vote_type', $vote_type);
    $stmt->bindParam(':date_vote', $date_vote);

    return $stmt->execute();
  }

  public function delete($id)
  {
    $query = "DELETE FROM comment_likes WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }
}
