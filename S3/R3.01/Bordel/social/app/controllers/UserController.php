<?php

namespace App\R301\Controller;
use App\R301\Model\User;

class UserController
{

  private $userModel;
  public function __construct()
  {
    $this->userModel = new User();
  }

  function inscription()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'register.php');
  }

  function connexion()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'login.php');
  }

  function enregistrer()
  {
    $nom = $_POST['nom'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $date_creation = date('Y-m-d H:i:s');

    $password = password_hash($password, PASSWORD_DEFAULT);

    if (isset($_GET['id'])) {
      $ajoutOk = $this->userModel->update($_GET['id'], $nom, $email, $password);
    } else {
      $ajoutOk = $this->userModel->add($nom, $email, $password, $date_creation);
    }

    if ($ajoutOk) {
      header('Location: index.php?c=user&a=connexion'); 
      exit();
    } else {
      echo "Erreur lors de l'enregistrement de l'utilisateur.";
    }
  }

  function verifieConnexion()
  {
    $email = $_POST['email'];
    $pwd = $_POST['pwd'];

    $user = $this->userModel->findBy(['email' => $email]);
    
    if ($user && password_verify($pwd, $user[0]['password'])) {
      $_SESSION['id'] = $user[0]['id'];
      $_SESSION['email'] = $user[0]['email'];
      $_SESSION['nom'] = $user[0]['nom'];

      header('Location: ?c=post&a=index');
      exit();
    } else {
      echo "Nom ou mot de passe incorrect.";
    }
  }

  function deconnexion()
  {
    session_unset();
    session_destroy();
    header('Location: ?c=home');
    exit();
  }

  function profil()
  {
    if (!isset($_GET['id'])) {
      header('Location: ?c=home');
      exit();
    }

    $userId = intval($_GET['id']);
    $user = $this->userModel->find($userId);

    if (!$user) {
      echo "Utilisateur non trouvé.";
      exit();
    }

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'profil.php');
  }

  public function profile() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        if (!isset($_SESSION['id'])) {
            header('Location: index.php?c=user&a=connexion');
            exit;
        }

        $message = "";

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $nom = $_POST['nom'];
            $email = $_POST['email'];
            
            if (!empty($nom) && !empty($email)) {
                $updateOk = $this->userModel->update($_SESSION['id'], $nom, $email, null);
                if ($updateOk) {
                    $_SESSION['nom'] = $nom;
                    $message = "✅ Profil mis à jour avec succès !";
                } else {
                    $message = "❌ Erreur lors de la mise à jour.";
                }
            } else {
                $message = "❌ Veuillez remplir tous les champs.";
            }
        }

        $user = $this->userModel->find($_SESSION['id']);
        
        require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'profile.php');
    }
}