<div class="container mt-4">
    <div class="mb-3">
        <a href="?c=post&a=index" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Retour aux publications
        </a>
    </div>

    <?php if (!empty($post)): ?>
        <div class="card">
            <div class="card-body">
                <h2 class="card-title mb-4">Modifier le post</h2>
                <form action="?c=post&a=enregistrer&id=<?= $post['id'] ?>" method="POST">
                    <div class="mb-3">
                        <label for="titre" class="form-label">Titre</label>
                        <input type="text" class="form-control" id="titre" name="titre" value="<?= htmlspecialchars($post['titre']) ?>" required>
                    </div>
                    <div class="mb-3">
                        <label for="contenu" class="form-label">Contenu</label>
                        <textarea class="form-control" id="contenu" name="contenu" rows="6" required><?= htmlspecialchars($post['contenu']) ?></textarea>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Enregistrer les modifications
                        </button>
                        <a href="?c=post&a=index" class="btn btn-secondary">
                            <i class="bi bi-x-circle"></i> Annuler
                        </a>
                    </div>
                </form>
            </div>
        </div>
    <?php else: ?>
        <div class="alert alert-warning" role="alert">
            <i class="bi bi-exclamation-triangle"></i> Le post demandé n'existe pas.
        </div>
    <?php endif; ?>
</div>
