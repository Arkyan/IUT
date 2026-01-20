<div class="container mt-4">
    <div class="mb-3">
        <a href="?c=post&a=index" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Retour aux publications
        </a>
    </div>

    <?php if (!empty($post)): ?>
        <div class="card mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <div>
                        <h2 class="card-title"><?= htmlspecialchars($post['titre']) ?></h2>
                        <div class="text-muted small">
                            <span><i class="bi bi-person"></i> <?= htmlspecialchars($post['auteur'] ?? 'Anonyme') ?></span>
                            <span class="ms-3"><i class="bi bi-calendar"></i> <?= htmlspecialchars($post['date_publication'] ?? '') ?></span>
                        </div>
                    </div>
                    <?php if (isset($_SESSION['id']) && $_SESSION['id'] == $post['utilisateur_id']): ?>
                        <div class="btn-group" role="group">
                            <a href="?c=post&a=modifier&id=<?= $post['id'] ?>" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil"></i> Modifier
                            </a>
                            <a href="?c=post&a=supprimer&id=<?= $post['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce post ?');">
                                <i class="bi bi-trash"></i> Supprimer
                            </a>
                        </div>
                    <?php endif; ?>
                </div>

                <div class="card-text mb-4">
                    <?= htmlspecialchars($post['contenu']) ?>
                </div>
                <div class="d-flex gap-2 border-top pt-3">
                    <button class="btn btn-like btn-outline-danger" data-post-id="<?= $post['id'] ?>">
                        <i class="bi bi-heart"></i> <span class="like-count">0</span> J'aime
                    </button>
                    <a href="?c=post&a=index" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left"></i> Retour
                    </a>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h4><i class="bi bi-chat"></i> Commentaires</h4>
            </div>
            <div class="card-body">
                <?php if (isset($_SESSION['id'])): ?>
                    <div class="mb-4">
                        <h5>Ajouter un commentaire</h5>
                        <form action="?c=comment&a=ajouter" method="POST">
                            <input type="hidden" name="post_id" value="<?= $post['id'] ?>">
                            <div class="mb-3">
                                <textarea class="form-control" name="contenu" rows="3" placeholder="Votre commentaire..." required></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-send"></i> Publier le commentaire
                            </button>
                        </form>
                    </div>
                    <hr>
                <?php else: ?>
                    <div class="alert alert-info mb-4" role="alert">
                        <i class="bi bi-info-circle"></i> <a href="?c=user&a=connexion">Connectez-vous</a> pour ajouter un commentaire.
                    </div>
                <?php endif; ?>

                <?php if (!empty($comments)): ?>
                    <h5 class="mb-3">
                        <i class="bi bi-chat-dots"></i> <?= count($comments) ?> commentaire<?= count($comments) > 1 ? 's' : '' ?>
                    </h5>
                    <div class="comments-list">
                        <?php foreach ($comments as $comment): ?>
                            <div class="card mb-3" data-comment-card="<?= $comment['id'] ?>">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div class="flex-grow-1">
                                            <div class="d-flex align-items-center">
                                                <strong class="me-2"><?= htmlspecialchars($comment['auteur'] ?? 'Anonyme') ?></strong>
                                                <span class="text-muted small">
                                                    <i class="bi bi-calendar-event"></i> <?= htmlspecialchars($comment['date_commentaire'] ?? '') ?>
                                                </span>
                                            </div>
                                        </div> 
                                        <?php if (isset($_SESSION['id']) && $_SESSION['id'] == $comment['utilisateur_id']): ?>
                                            <div class="btn-group" role="group">
                                                <button class="btn btn-edit-comment btn-sm btn-outline-primary" data-comment-id="<?= $comment['id'] ?>" title="Modifier">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <a href="?c=comment&a=supprimer&id=<?= $comment['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce commentaire ?');" title="Supprimer">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        <?php endif; ?>
                                    </div>
                                    <p class="card-text comment-content mb-2">
                                        <?= htmlspecialchars($comment['contenu']) ?>
                                    </p>
                                    <div class="vote-container d-flex align-items-center gap-2" data-comment-id="<?= $comment['id'] ?>">
                                        <button class="btn btn-upvote btn-sm btn-outline-success">
                                            <i class="bi bi-arrow-up-circle"></i>
                                        </button>
                                        <span class="vote-score fw-bold">0</span>
                                        <button class="btn btn-downvote btn-sm btn-outline-danger">
                                            <i class="bi bi-arrow-down-circle"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php else: ?>
                    <div class="alert alert-info" role="alert">
                        <i class="bi bi-chat-dots"></i> Aucun commentaire pour le moment. Soyez le premier à commenter !
                    </div>
                <?php endif; ?>
            </div>
        </div>
    <?php else: ?>
        <div class="alert alert-warning" role="alert">
            <i class="bi bi-exclamation-triangle"></i> Le post demandé n'existe pas.
        </div>
    <?php endif; ?>
</div>

<script src="/social/public/comment.js"></script>
<script src="/social/public/likes.js"></script>
<script src="/social/public/votes.js"></script>
<script src="/social/public/comment-edit.js"></script>