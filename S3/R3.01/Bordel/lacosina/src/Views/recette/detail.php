<div class="container-fluid py-5">
    <div class="mb-4">
        <a href="?c=recette&a=index" class="btn btn-outline-primary mb-3">
            <i class="bi bi-arrow-left"></i> Retour à la liste des recettes
        </a>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <img src="<?php echo isset($recipe['image']) && $recipe['image'] ? $recipe['image'] : 'upload/no_image.png'; ?>"
                class="img-fluid rounded shadow-sm"
                alt="<?php echo isset($recipe['image']) && $recipe['image'] ? htmlspecialchars($recipe['titre']) : 'Recette par défaut'; ?>">
        </div>
        <div class="col-md-8">
            <h1 class="display-5 mb-3"><?php echo htmlspecialchars($recipe['titre']); ?></h1>
            <p class="lead text-muted mb-4"><?php echo htmlspecialchars($recipe['description']); ?></p>
            <p class="mb-4"><strong>Auteur :</strong> <a href="mailto:<?php echo htmlspecialchars($recipe['auteur']); ?>"><?php echo htmlspecialchars($recipe['auteur']); ?></a></p>

            <div class="d-flex gap-2 flex-wrap">
                <?php if (isset($isFavori) && $isFavori): ?>
                    <a href="?c=favoris&a=retirer&id=<?php echo $recipe['id']; ?>" class="btn btn-danger">
                        <i class="bi bi-heart-fill"></i> Retirer des favoris
                    </a>
                <?php else: ?>
                    <a href="?c=favoris&a=ajouter&id=<?php echo $recipe['id']; ?>" class="btn btn-primary">
                        <i class="bi bi-heart"></i> Ajouter aux favoris
                    </a>
                <?php endif; ?>
                <button id="toggleCommentSection" class="btn btn-primary">
                    <i class="bi bi-chat-left-text"></i> Ajouter un commentaire
                </button>
                <a href="?c=recette&a=modifier&id=<?php echo $recipe['id']; ?>" class="btn btn-warning">
                    <i class="bi bi-pencil-square"></i> Modifier la recette
                </a>
            </div>
        </div>
    </div>

    <hr class="my-5">

    <div class="row">
        <div class="col-md-8 mx-auto">
            <h2 class="mb-4">
                <i class="bi bi-chat-dots"></i> Commentaires
            </h2>

            <section id="comment_area" hidden class="mb-5">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <form method="post" action="?c=commentaire&a=ajouter&id_recette=<?php echo $recipe['id']; ?>">
                            <textarea id="commentaire" name="commentaire" rows="4" placeholder="Ajouter un commentaire..." class="form-control mb-3"></textarea>
                            <button id="submitComment" class="btn btn-primary">
                                <i class="bi bi-send"></i> Envoyer
                            </button>
                        </form>
                    </div>
                </div>
            </section>

            <?php if (count($comments) === 0): ?>
                <div class="alert alert-info text-center" role="alert">
                    <i class="bi bi-info-circle"></i> Aucun commentaire pour cette recette.
                </div>
            <?php else: ?>
                <div class="row g-3">
                    <?php foreach ($comments as $comment): ?>
                        <div class="col-md-12">
                            <div class="card border-0 shadow-sm">
                                <div class="card-body">
                                    <div class="d-flex flex-column h-100">
                                        <p class="card-text mb-3"><strong><?php echo htmlspecialchars($comment['pseudo']); ?></strong></p>
                                        <p class="card-text text-muted flex-grow-1"><?php echo nl2br(htmlspecialchars($comment['commentaire'])); ?></p>
                                        <p class="card-text text-end mb-0"><small class="text-muted"><strong>Par <?php echo htmlspecialchars($comment['pseudo']); ?> le <?php echo htmlspecialchars($comment['create_time']); ?></strong></small></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>