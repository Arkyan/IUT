<div class="container mt-4">
    <h1 class="mb-4">Recettes en cours de validation</h1>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Titre</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <?php
                foreach ($recipes as $recipe) {
                ?>
                    <tr>
                        <td><?php echo htmlspecialchars($recipe['titre']); ?></td>
                        <td><?php echo htmlspecialchars($recipe['description']); ?></td>
                    </tr>
                <?php
                }
                ?>
            </tbody>
        </table>
    </div>
</div>