<h1>Ajouter / Éditer un livre</h1>

<form action="?c=livre&a=enregistrer" method="post">
    <div class="mb-3">
        <label for="titre" class="form-label">Titre du livre</label>
        <input type="text" class="form-control" id="titre" name="titre" required>
    </div>
    <div class="mb-3">
        <label for="auteur" class="form-label">Auteur</label>
        <input type="text" class="form-control" id="auteur" name="auteur" required>
    </div>
    <div class="mb-3">
        <label for="categorie" class="form-label">Catégorie</label>
        <input type="text" class="form-control" id="categorie" name="categorie" required>
    </div>
    <div class="mb-3">
        <label for="annee_publication" class="form-label">Année de publication</label>
        <input type="number" class="form-control" id="annee_publication" name="annee_publication" required>
    </div>
    <div class="mb-3">
        <label for="isbn" class="form-label">ISBN</label>
        <input type="text" class="form-control" id="isbn" name="isbn" required>
    </div>

    <button type="submit" class="btn btn-primary">Ajouter votre livre</button>

    <a href="?c=livre&a=index" class="btn btn-secondary">Retour à la liste des livres</a>
</form>