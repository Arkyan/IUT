<?php

namespace App\R301\Controller;

use App\R301\Model\Contact;

class ContactController
{

  private $contactModel;

  public function __construct()
  {
    $this->contactModel = new Contact();
  }

  function index()
  {
    $contacts = $this->contactModel->findAll();
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'contact' . DIRECTORY_SEPARATOR . 'listContact.php');
  }

  function ajouter()
  {
    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'contact' . DIRECTORY_SEPARATOR . 'ajoutContact.php');
  }

  function enregistrer()
  {
    $nom = $_POST['nom'];
    $email = $_POST['email'];
    $description = $_POST['description'];

    $this->contactModel->enregistrer($nom, $email, $description);

    require_once(__DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'Views' . DIRECTORY_SEPARATOR . 'recette' . DIRECTORY_SEPARATOR . 'enregistrer.php');
  }
}
