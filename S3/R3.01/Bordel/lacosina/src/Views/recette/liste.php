<h1>Recettes</h1>
<div class="row">
  <div class="mb-3">
    <div class="card-deck d-flex gap-3 mb-4">
      <div class="card bg-primary-subtle filter-card" data-filter="all" style="cursor: pointer;">
        <div class="card-body text-center">
          <h5 class="card-title">Toutes les recettes</h5>
        </div>
      </div>
      <div class="card filter-card" data-filter="entree" style="cursor: pointer;">
        <div class="card-body text-center">
          <h5 class="card-title">Entrées</h5>
        </div>
      </div>
      <div class="card filter-card" data-filter="plat" style="cursor: pointer;">
        <div class="card-body text-center">
          <h5 class="card-title">Plats</h5>
        </div>
      </div>
      <div class="card filter-card" data-filter="dessert" style="cursor: pointer;">
        <div class="card-body text-center">
          <h5 class="card-title">Desserts</h5>
        </div>
      </div>
    </div>
  </div>
  <div id="listeRecettes" class="row">
    <?php foreach ($recipes as $recipe): ?>
      <div class="col-4 p-2">

        <span class="edit-btn" data-id="<?php echo $recipe['id']; ?>" style="cursor: pointer; color: blue;">
          <i class="bi bi-pencil-square"></i>
        </span>

        <?php if (isset($recipe['is_favorite']) && $recipe['is_favorite']): ?>
          <span class="favorite-btn" data-id="<?php echo $recipe['id']; ?>" style="cursor: pointer; color: red;">
            <i class="bi bi-heart-fill"></i>
          </span>
        <?php else: ?>
          <span class="favorite-btn" data-id="<?php echo $recipe['id']; ?>" style="cursor: pointer;">
            <i class="bi bi-heart"></i>
          </span>
        <?php endif; ?>
        <div class="recipe card" data-id="<?php echo $recipe['id']; ?>">
          <div class="card-body">
            <h2 class="card-title"><?php echo $recipe['titre']; ?></h2>
            <img
              src="<?php echo !empty($recipe['image']) ? $recipe['image'] : 'upload/no_image.png'; ?>"
              alt="Image de <?php echo $recipe['titre']; ?>"
              class="card-img-top">
            <p class="card-text"><?php echo $recipe['description']; ?></p>
            <a href="mailto:<?php echo $recipe['auteur']; ?>"><?php echo $recipe['auteur']; ?></a>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
</div>
<a href="?c=home" class="btn btn-primary">Retour à l'accueil</a>