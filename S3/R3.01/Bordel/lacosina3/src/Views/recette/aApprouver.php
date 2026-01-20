<div class="container mt-4">
    <h1 class="mb-4">Recettes à Approuver</h1>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Titre</th>
                    <th>Description</th>
                    <th>Auteur</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($recipes as $recipe) {
                ?>
                    <tr>
                        <td><?php echo htmlspecialchars($recipe['titre']); ?></td>
                        <td><?php echo htmlspecialchars($recipe['description']); ?></td>
                        <td><?php echo htmlspecialchars($recipe['auteur']); ?></td>
                        <td>
                            <button class="btn btn-success btn-sm" onclick="validerRecette(<?php echo $recipe['id']; ?>)">
                                <i class="fas fa-check"></i> Valider
                            </button>
                        </td>
                    </tr>
                <?php
                }
                ?>
            </tbody>
        </table>
    </div>
</div>

<script>
    function validerRecette(id) {
        if (confirm('Voulez-vous vraiment valider cette recette ?')) {
            window.location.href = '?c=recette&a=valider&id=' + id;
        }
    }
</script>