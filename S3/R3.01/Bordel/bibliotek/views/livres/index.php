<body>
    <h1>Livres</h1>
    <p><a href="?c=livre&a=ajouter" class="btn btn-success">Ajouter un livre</a></p>
    <div class="row">
        <?php if (!empty($livres)): ?>
                    <?php foreach ($livres as $livre): ?>
                        <div class="col-4 p-2">
                            <div class="card clickable-card" data-href="?c=livre&a=detail&id=<?php echo urlencode($livre['id']); ?>">
                                <div class="card-body">
                            <h2 class="card-title"><?php echo htmlspecialchars($livre['titre']); ?></h2>
                            <p class="card-text">Auteur: <?php echo htmlspecialchars($livre['auteur']); ?></p>
                            <p class="card-text">Catégorie: <?php echo htmlspecialchars($livre['categorie']); ?></p>
                            <p class="card-text">Année: <?php echo htmlspecialchars($livre['annee_publication']); ?></p>
                            <p class="card-text">ISBN: <?php echo htmlspecialchars($livre['isbn']); ?></p>
                            <p>
                                <a href="?c=livre&a=supprimer&id=<?php echo urlencode($livre['id']); ?>" onclick="return confirm('Supprimer ce livre ?')" class="btn btn-sm btn-danger">Supprimer</a>
                            </p>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p>Aucun livre trouvé.</p>
        <?php endif; ?>
    </div>
    <a href="?c=home" class="btn btn-primary">Retour à l'accueil</a>
</body>