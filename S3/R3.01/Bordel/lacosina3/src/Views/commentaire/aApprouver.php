<div class="container mt-4">
    <h1 class="mb-4">Commentaires à Approuver</h1>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Commentaire</th>
                    <th>Recette</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($comments as $comment) {
                ?>
                    <tr>
                        <td><?php echo htmlspecialchars($comment['commentaire']); ?></td>
                        <td><?php echo htmlspecialchars($comment['recette_id']); ?></td>
                        <td>
                            <button class="btn btn-success btn-sm" onclick="validerCommentaire(<?php echo $comment['id']; ?>)">
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
    function validerCommentaire(id) {
        if (confirm('Voulez-vous vraiment valider ce commentaire ?')) {
            window.location.href = '?c=commentaire&a=valider&id=' + id;
        }
    }
</script>