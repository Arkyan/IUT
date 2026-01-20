<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
        <h1>Publications</h1>
        <button id="btnNouveauPost" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Créer un post
        </button>
    </div>

    <div id="formulairePost" class="card mb-4" style="display: none;">
        <div class="card-body">
            <h5 class="card-title mb-3">Nouveau post</h5>
            <form action="?c=post&a=enregistrer" method="POST">
                <div class="mb-3">
                    <label for="titre" class="form-label">Titre</label>
                    <input type="text" class="form-control" id="titre" name="titre" required>
                </div>
                <div class="mb-3">
                    <label for="contenu" class="form-label">Contenu</label>
                    <textarea class="form-control" id="contenu" name="contenu" rows="5" required></textarea>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-send"></i> Publier
                    </button>
                    <button type="button" id="btnAnnuler" class="btn btn-secondary">
                        <i class="bi bi-x-circle"></i> Annuler
                    </button>
                </div>
            </form>
        </div>
    </div>

    <div id="listePosts">
        <?php if (!empty($posts)): ?>
            <?php foreach ($posts as $post): ?>
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title"><?= htmlspecialchars($post['titre']) ?></h5>
                        <p class="card-text"><?= htmlspecialchars($post['contenu']) ?></p>
                        <div class="d-flex justify-content-between text-muted small border-top pt-2 align-items-center">
                            <div>
                                <span><i class="bi bi-person"></i> <?= htmlspecialchars($post['auteur'] ?? 'Anonyme') ?></span>
                                <span class="ms-3"><i class="bi bi-calendar"></i> <?= htmlspecialchars($post['date_publication'] ?? '') ?></span>
                            </div>
                            <div>
                                <button class="btn btn-like btn-sm btn-outline-danger me-2" data-post-id="<?= $post['id'] ?>">
                                    <i class="bi bi-heart"></i> <span class="like-count">0</span>
                                </button>
                                <a href="?c=post&a=detail&id=<?= $post['id'] ?>" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-chat"></i> Commenter
                                </a>
                                <?php if (isset($_SESSION['id']) && $_SESSION['id'] == $post['utilisateur_id']): ?>
                                    <a href="?c=post&a=modifier&id=<?= $post['id'] ?>" class="btn btn-sm btn-warning">
                                        <i class="bi bi-pencil"></i> Modifier
                                    </a>
                                    <a href="?c=post&a=supprimer&id=<?= $post['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce post ?');">
                                        <i class="bi bi-trash"></i> Supprimer
                                    </a>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <div class="alert alert-info" role="alert">
                <i class="bi bi-info-circle"></i> Aucun post pour le moment.
            </div>
        <?php endif; ?>
    </div>
</div>

<script src="/social/public/likes.js"></script>
<script>
document.getElementById('btnNouveauPost').addEventListener('click', function() {
    document.getElementById('formulairePost').style.display = 'block';
    this.style.display = 'none';
});

document.getElementById('btnAnnuler').addEventListener('click', function() {
    document.getElementById('formulairePost').style.display = 'none';
    document.getElementById('btnNouveauPost').style.display = 'block';
});
</script>