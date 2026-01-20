<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Social</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="public/search-styles.css">
  <link rel="stylesheet" href="public/styles.css">
  <link rel="stylesheet" href="public/theme-toggle.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>

<body>
  <nav class="navbar navbar-expand-lg bg-body-tertiary justify-content-between">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href='?c=home'>Accueil</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href='?c=post&a=index'>Post</a>
      </li>
      <?php if (isset($_SESSION['nom'])) { ?>
        <div class="vr"></div>
        <li class="nav-item dropdown">
          <a class="nav-link position-relative" href="#" id="notificationBtn" role="button">
            <i class="bi bi-bell fs-5"></i>
            <span id="notificationBadge" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="display: none;">
              0
            </span>
          </a>
          <div id="notificationDropdown" class="dropdown-menu dropdown-menu-end notification-dropdown" style="min-width: 350px; max-height: 500px; overflow-y: auto;">
            <div class="dropdown-header d-flex justify-content-between align-items-center">
              <span class="fw-bold">Notifications</span>
              <button id="markAllReadBtn" class="btn btn-sm btn-outline-secondary">
                <i class="bi bi-check-all"></i> Tout marquer comme lu
              </button>
            </div>
            <div class="dropdown-divider"></div>
            <div id="notificationList">
              <div class="dropdown-item text-center text-muted py-3">
                <i class="bi bi-hourglass-split"></i> Chargement...
              </div>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="?c=user&a=profile" role="button">
            Bienvenue <?php echo $_SESSION['nom']; ?>
          </a>
        </li>
      <?php } ?>
    </ul>

    <div class="search-container">
      <div class="input-group search-input-group">
        <input type="text" id="searchInput" class="form-control" placeholder="Chercher utilisateurs, posts, commentaires..." aria-label="Rechercher">
      </div>
      <div id="searchResults" class="search-results-dropdown"></div>
    </div>

    <ul class="navbar-nav">
      <li class="nav-item">
        <button id="themeToggle" class="btn btn-outline-dark" type="button" title="Passer en mode sombre">
          <i class="bi bi-moon-fill"></i>
        </button>
      </li>
      <?php if (isset($_SESSION['nom'])) { ?>
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
  <div class="container w-75 m-auto mt-3"> </div>

  <script src="public/search.js"></script>
  <script src="public/theme-toggle.js"></script>
  <?php if (isset($_SESSION['id'])) { ?>
    <script src="public/notifications.js"></script>
  <?php } ?>