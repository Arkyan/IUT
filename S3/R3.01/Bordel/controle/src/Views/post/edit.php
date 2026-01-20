<?php require 'src/Views/layout/header.php'; ?>

<div style="max-width: 600px; margin: 0 auto;">
    <h2>✏️ Modifier le message</h2>
    
    <form method="POST" style="display: flex; flex-direction: column; gap: 15px;">
        
        <div>
            <label for="titre" style="display: block; font-weight: bold;">Titre :</label>
            <input type="text" name="titre" id="titre" 
                   value="<?= htmlspecialchars($post['titre']) ?>" 
                   required 
                   style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px;">
        </div>

        <div>
            <label for="contenu" style="display: block; font-weight: bold;">Contenu :</label>
            <textarea name="contenu" id="contenu" rows="6" required 
                      style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-family: sans-serif;"><?= htmlspecialchars($post['contenu']) ?></textarea>
        </div>

        <div style="display: flex; gap: 10px;">
            <button type="submit" style="background: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 1em;">
                ✅ Enregistrer les modifications
            </button>
            
            <a href="index.php" style="background: #6c757d; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">
                Annuler
            </a>
        </div>
    </form>
</div>

<?php require 'src/Views/layout/footer.php'; ?>