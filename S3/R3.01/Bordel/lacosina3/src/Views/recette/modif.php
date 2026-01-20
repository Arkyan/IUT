<h1>
  Modifier la recette : <?php echo $recipe['titre']; ?>
</h1>
<form action="?c=recette&a=enregistrer&id=<?php echo $recipe['id']; ?>" method="post" enctype="multipart/form-data">
  <div class="mb-3">
    <label for="title" class="form-label">Titre de la recette</label>
    <input type="text" class="form-control" id="title" name="title" value="<?php echo $recipe['titre']; ?>" required>
  </div>
  <div class="mb-3">
    <label for="description" class="form-label">Description de la recette</label>
    <textarea class="form-control" id="description" name="description" rows="5" required><?php echo $recipe['description']; ?></textarea>
  </div>
  <div class="mb-3">
    <label for="auteur" class="form-label">Mail de l'auteur</label>
    <input type="email" class="form-control" id="auteur" name="auteur" value="<?php echo $recipe['auteur']; ?>" required>
  </div>
  <div class="mb-3">
    <label for="image" class="form-label">Image de la recette <br> (pour la modifier, merci de choisir une nouvelle image)</label>
    <img class="rounded w-25 mx-auto img-fluid card-img-top" src="<?php echo $recipe['image'] != '' ? $recipe['image'] : 'upload/no_image.png'; ?>" alt="<?php echo $recipe['titre']; ?>">
    <input class="form-control"
      type="file"
      value="<?php echo $recipe['image'] != '' ? $recipe['image'] : 'upload/no_image.png'; ?>"
      id="image" name="image">
  </div>
  
  <div class="mb-3">
    <label for="type_plat" class="form-label">Type de plat</label>
    <select class="form-select" id="type_plat" name="type_plat" required>
      <option value="entree" <?php echo $recipe['type_plat'] == 'entree' ? 'selected' : ''; ?>>Entrée</option>
      <option value="plat" <?php echo $recipe['type_plat'] == 'plat' ? 'selected' : ''; ?>>Plat</option>
      <option value="dessert" <?php echo $recipe['type_plat'] == 'dessert' ? 'selected' : ''; ?>>Dessert</option>
    </select>
  </div>
  <button type="submit" class="btn btn-primary">Enregistrer</button>
</form>