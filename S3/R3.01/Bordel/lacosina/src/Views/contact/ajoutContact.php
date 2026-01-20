<h1>
  Formulaire de contact
</h1>
<form action="?c=enregistrerMail&a=enregistrer" method="post">
  <div class="mb-3">
    <label for="title" class="form-label">Votre Nom</label>
    <input type="text" class="form-control" id="nom" name="nom" required>
  </div>
  <div class="mb-3">
    <label for="email" class="form-label">Votre mail</label>
    <input type="email" class="form-control" id="email" name="email" required>
  </div>
  <div class="mb-3">
    <label for="description" class="form-label">description</label>
    <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
  </div>
  <button type="submit" class="btn btn-primary">Enregistrer</button>
</form>