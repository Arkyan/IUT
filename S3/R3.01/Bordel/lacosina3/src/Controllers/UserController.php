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
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'inscription.php');
  }

  function enregistrer()
  {
    $identifiant = $_POST['identifiant'];
    $password = $_POST['password'];
    $mail = $_POST['mail'];

    $password = password_hash($password, PASSWORD_DEFAULT);

    if (isset($_GET['id'])) {
      $ajoutOk = $this->userModel->update($_GET['id'], $identifiant, $password, $mail);
    } else {
      $ajoutOk = $this->userModel->add($identifiant, $password, $mail);
    }
    if ($ajoutOk) {
      require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'enregistrement.php');
    } else {
      echo "Erreur lors de l'enregistrement de l'utilisateur.";
    }
  }

  function connexion()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'connexion.php');
  }

  function verifieConnexion()
  {
    $identifiant = $_POST['identifiant'];
    $pwd = $_POST['pwd'];

    $user = $this->userModel->findBy(['identifiant' => $identifiant]);
    if ($user && password_verify($pwd, $user[0]['password'])) {
      $_SESSION['id'] = $user[0]['id'];
      $_SESSION['identifiant'] = $user[0]['identifiant'];
      $_SESSION['mail'] = $user[0]['mail'];
      $_SESSION['isAdmin'] = $user[0]['isAdmin'];
      header('Location: ?c=home');
      exit();
    } else {
      // Échec de l'authentification
      echo "Identifiant ou mot de passe incorrect.";
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
    if (!isset($_SESSION['id'])) {
      header('Location: ?c=user&a=connexion');
      exit();
    }
    $user = $this->userModel->find($_SESSION['id']);
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'user' . DIRECTORY_SEPARATOR . 'profil.php');
  }
}
