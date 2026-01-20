<?php

namespace App\R301\Model;

class Post
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function findAll()
  {
    $query = "SELECT p.*, u.nom as auteur FROM posts p LEFT JOIN users u ON p.utilisateur_id = u.id ORDER BY p.date_publication DESC";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function find($id)
  {
    $query = "SELECT p.*, u.nom as auteur FROM posts p LEFT JOIN users u ON p.utilisateur_id = u.id WHERE p.id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(\PDO::FETCH_ASSOC);
  }

  public function findBy(array $params)
  {
    $query = "SELECT * FROM posts WHERE " . implode(' AND ', array_map(function ($key) {
      return "$key = :$key";
    }, array_keys($params)));
    $stmt = $this->conn->prepare($query);
    foreach ($params as $key => $value) {
      $stmt->bindValue(":$key", $value);
    }
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }

  public function add($titre, $contenu, $utilisateur_id, $date_publication)
  {

    $query = "INSERT INTO posts (titre, contenu, utilisateur_id, date_publication)
    VALUES (:titre, :contenu, :utilisateur_id, :date_publication)";
    $stmt = $this->conn->prepare(query: $query);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':contenu', $contenu);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':date_publication', $date_publication);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function update($id, $titre, $contenu, $utilisateur_id, $date_publication)
  {

    $query = "UPDATE posts 
              SET titre = :titre, contenu = :contenu, utilisateur_id = :utilisateur_id, date_publication = :date_publication
              WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':contenu', $contenu);
    $stmt->bindParam(':utilisateur_id', $utilisateur_id);
    $stmt->bindParam(':date_publication', $date_publication);

    return $stmt->execute();
  }

  public function delete($id)
  {

    $queryLikes = "DELETE FROM post_likes WHERE post_id = :id";
    $stmtLikes = $this->conn->prepare($queryLikes);
    $stmtLikes->bindParam(':id', $id);
    $stmtLikes->execute();

    $queryCommentVotes = "DELETE FROM comment_likes WHERE comment_id IN (SELECT id FROM comments WHERE post_id = :id)";
    $stmtCommentVotes = $this->conn->prepare($queryCommentVotes);
    $stmtCommentVotes->bindParam(':id', $id);
    $stmtCommentVotes->execute();

    $queryComments = "DELETE FROM comments WHERE post_id = :id";
    $stmtComments = $this->conn->prepare($queryComments);
    $stmtComments->bindParam(':id', $id);
    $stmtComments->execute();

    $query = "DELETE FROM posts WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }

  public function search($query, $limit = 5)
  {
    $searchQuery = "%$query%";
    $sql = "SELECT p.id, p.titre, p.contenu, u.nom as user_name FROM posts p LEFT JOIN users u ON p.utilisateur_id = u.id WHERE p.titre LIKE :query OR p.contenu LIKE :query ORDER BY p.date_publication DESC LIMIT :limit";
    $stmt = $this->conn->prepare($sql);
    $stmt->bindParam(':query', $searchQuery);
    $stmt->bindParam(':limit', $limit, \PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(\PDO::FETCH_ASSOC);
  }
}
