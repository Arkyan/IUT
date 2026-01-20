<div class="container-fluid py-5">
    <div class="mb-4">
        <h1 class="display-5 mb-3">Tous les commentaires</h1>
        <button onclick="window.location.href='?c=home'" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left"></i> Retour à l'accueil
        </button>
    </div>

    <?php if (empty($commentaires)): ?>
        <div class="alert alert-info text-center" role="alert">
            <i class="bi bi-info-circle"></i> Aucun commentaire pour le moment.
        </div>
    <?php else: ?>
        <div class="row g-4">
            <?php foreach ($commentaires as $commentaire): ?>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm border-0 transition">
                        <div class="card-header bg-light d-flex justify-content-between align-items-center">
                            <h6 class="card-title mb-0"><?php echo htmlspecialchars($commentaire['pseudo']); ?></h6>
                            <i class="bi bi-trash text-danger cursor-pointer"
                                style="cursor: pointer; font-size: 1.2rem;"
                                onclick="if(confirm('Êtes-vous sûr de vouloir supprimer ce commentaire ?')) { window.location.href='?c=commentaire&a=supprimer&id=<?php echo $commentaire['id']; ?>'; }"></i>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <p class="card-text text-muted flex-grow-1"><?php echo nl2br(htmlspecialchars($commentaire['commentaire'])); ?></p>
                        </div>
                        <div class="card-footer bg-light border-top">
                            <small class="text-muted"><strong>Par <?php echo htmlspecialchars($commentaire['pseudo']); ?></strong></small>
                            <br>
                            <small class="text-muted"><?php echo htmlspecialchars($commentaire['create_time']); ?></small>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>