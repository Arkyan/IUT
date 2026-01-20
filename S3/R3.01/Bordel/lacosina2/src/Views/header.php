<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>La Cosina</title>
  <!-- Bootstrap CSS and JS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <script src="./src/Views/js/recipes.js" defer></script>
  <script src="./src/Views/js/users.js" defer></script>
  <script src="./src/Views/js/search.js" defer></script>
</head>

<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary justify-content-between">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href='?c=home'>Accueil</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href='?c=recette&a=index'>Recettes</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href='?c=contact&a=ajouter'>Contact</a>
      </li>
      <?php if (isset($_SESSION['identifiant'])) { ?>
        <div class="vr"></div>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Bienvenue <?php echo $_SESSION['identifiant']; ?>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href='?c=user&a=profil'>Mon profil</a></li>
            <li><a class="dropdown-item" href='?c=favoris&a=afficher'>Mes recettes favorites</a></li>
            <li><a class="dropdown-item" href='?c=recette&a=ajouter'>Ajouter une recette</a></li>
            <?php if (isset($_SESSION['isAdmin']) && $_SESSION['isAdmin']) { ?>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href='?c=commentaire&a=liste'>Liste des commentaires</a></li>
            <?php } ?>
          </ul>
        </li>
      <?php } ?>
    </ul>

    <input type="search" id="search" placeholder="Rechercher une recette">

    <ul class="navbar-nav">
      <?php if (isset($_SESSION['identifiant'])) { ?>
        <li class="nav-item">
          <a class="btn btn-outline-dark" href='?c=user&a=deconnexion'>Déconnexion</a>
        </li>
      <?php } else { ?>
        <li class="nav-item">
          <a class="btn btn-outline-dark" href='?c=user&a=inscription'>Inscription</a>
        </li>
        <li class="nav-item">
          <a class="btn btn-outline-dark" href='?c=user&a=connexion'>Connexion</a>
        </li>
      <?php } ?>
    </ul>
  </nav>
  <?php if (isset($_SESSION['message'])) : ?>
    <?php foreach ($_SESSION['message'] as $type => $message) : ?>
      <div class="alert alert-<?php echo $type ?>">
        <?php echo $message ?>
      </div>
    <?php endforeach; ?>
    <?php unset($_SESSION['message']); ?>
  <?php endif; ?>
  <div class="container w-75 m-auto">