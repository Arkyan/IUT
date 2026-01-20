<body>
  <h1>Détails du livre</h1>
  <?php if (isset($livre) && is_array($livre)): ?>
    <div class="card">
      <div class="card-body">
        <h2 class="card-title"><?php echo htmlspecialchars($livre['titre']); ?></h2>
        <p class="card-text"><strong>Auteur :</strong> <?php echo htmlspecialchars($livre['auteur']); ?></p>
        <p class="card-text"><strong>Catégorie :</strong> <?php echo htmlspecialchars($livre['categorie']); ?></p>
        <p class="card-text"><strong>Année :</strong> <?php echo htmlspecialchars($livre['annee_publication']); ?></p>
        <p class="card-text"><strong>ISBN :</strong> <?php echo htmlspecialchars($livre['isbn']); ?></p>
      </div>
    </div>
  <?php else: ?>
    <p>Livre introuvable.</p>
  <?php endif; ?>

  <p>
    <a href="?c=livre&a=index" class="btn btn-secondary">Retour à la liste</a>
    <?php if (isset($livre['id'])): ?>
      <a href="?c=livre&a=supprimer&id=<?php echo urlencode($livre['id']); ?>" onclick="return confirm('Supprimer ce livre ?')" class="btn btn-danger">Supprimer</a>
    <?php endif; ?>
  </p>
</body>
