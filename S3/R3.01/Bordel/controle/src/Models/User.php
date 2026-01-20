<?php
namespace App\Models;

use PDO;

class User {
    private $pdo;

    public function __construct() {
        $this->pdo = Database::getConnection();
    }

    public function create($nom, $email, $password) {
        $hash = password_hash($password, PASSWORD_DEFAULT);
        $sql = "INSERT INTO users (nom, email, password) VALUES (:nom, :email, :pass)";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['nom' => $nom, 'email' => $email, 'pass' => $hash]);
    }

    public function findByEmail($email) {
        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE email = :email");
        $stmt->execute(['email' => $email]);
        return $stmt->fetch();
    }

    public function find($id) {
        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE id = :id");
        $stmt->execute(['id' => $id]);
        return $stmt->fetch();
    }

    public function update($id, $nom, $email) {
        $sql = "UPDATE users SET nom = :nom, email = :email WHERE id = :id";
        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute(['nom' => $nom, 'email' => $email, 'id' => $id]);
    }
}