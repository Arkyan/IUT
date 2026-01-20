<?php

require_once __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'models' . DIRECTORY_SEPARATOR . 'Database.php';

class Livre
{
  private $conn;

  function __construct()
  {
    $database = new Database();
    $this->conn = $database->getConnection();
  }

  public function trouver($id)
  {
    $query = "SELECT * FROM livres WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
  }

  public function obtenirLivres()
  {
    $query = "SELECT * FROM livres";
    $stmt = $this->conn->prepare($query);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
  }

  public function ajouterLivre($titre, $auteur, $categorie, $annee_publication, $isbn)
  {

    $query = "INSERT INTO livres (titre, auteur, categorie, annee_publication, isbn)
    VALUES (:titre, :auteur, :categorie, :annee_publication, :isbn)";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':titre', $titre);
    $stmt->bindParam(':auteur', $auteur);
    $stmt->bindParam(':categorie', $categorie);
    $stmt->bindParam(':annee_publication', $annee_publication);
    $stmt->bindParam(':isbn', $isbn);
    $stmt->execute();
    return $this->conn->lastInsertId();
  }

  public function supprimerLivre($id)
  {
    $query = "DELETE FROM livres WHERE id = :id";
    $stmt = $this->conn->prepare($query);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    return $stmt->rowCount() > 0;
  }
}
