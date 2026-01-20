<?php
namespace App\Controllers;

use App\Models\User;

class UserController {
    
    public function register() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $userModel = new User();
            if ($userModel->create($_POST['nom'], $_POST['email'], $_POST['password'])) {
                header('Location: index.php?page=login&success=1');
                exit;
            } else {
                echo "Erreur lors de l'inscription.";
            }
        }
        require 'src/Views/user/register.php';
    }

    public function login() {
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $userModel = new User();
            $user = $userModel->findByEmail($_POST['email']);

            if ($user && password_verify($_POST['password'], $user['password'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['user_nom'] = $user['nom'];
                header('Location: index.php');
                exit;
            } else {
                $error = "Identifiants incorrects";
            }
        }
        require 'src/Views/user/login.php';
    }

    public function logout() {
        session_destroy();
        header('Location: index.php?page=login');
        exit;
    }

    public function profile() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        if (!isset($_SESSION['user_id'])) {
            header('Location: index.php?page=connexion');
            exit;
        }

        $userModel = new \App\Models\User();
        $message = "";

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $nom = $_POST['nom'];
            $email = $_POST['email'];
            
            if (!empty($nom) && !empty($email)) {
                if ($userModel->update($_SESSION['user_id'], $nom, $email)) {
                    $_SESSION['user_nom'] = $nom;
                    $message = "✅ Profil mis à jour avec succès !";
                } else {
                    $message = "❌ Erreur lors de la mise à jour.";
                }
            } else {
                $message = "❌ Veuillez remplir tous les champs.";
            }
        }

        $user = $userModel->find($_SESSION['user_id']);
        
        require 'src/Views/user/profile.php';
    }

}