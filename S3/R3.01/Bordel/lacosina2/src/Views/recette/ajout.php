<h1>
  Ajouter une recette
</h1>
<form action="?c=recette&a=enregistrer" method="post" enctype="multipart/form-data">
  <div class="mb-3">
    <label for="title" class="form-label">Titre de la recette</label>
    <input type="text" class="form-control" id="title" name="title" required>
  </div>
  <div class="mb-3">
    <label for="description" class="form-label">Description de la recette</label>
    <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
  </div>
  <div class="mb-3">
    <label for="auteur" class="form-label">Mail de l'auteur</label>
    <input type="email" class="form-control" id="auteur" name="auteur" required>
  </div>
  <div class="mb-3">
    <label for="image" class="form-label">Image</label>
    <input type="file" class="form-control" id="image" name="image" required>
  </div>
  <div class="mb-3">
    <label for="type_plat" class="form-label">Type de plat</label>
    <select class="form-select" id="type_plat" name="type_plat" required>
      <option value="" selected disabled>Choisissez un type de plat</option>
      <option value="entree">Entrée</option>
      <option value="plat">Plat</option>
      <option value="dessert">Dessert</option>
    </select>
  </div>
  <button type="submit" class="btn btn-primary">Enregistrer</button>
</form>