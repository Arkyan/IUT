<?php require 'src/Views/layout/header.php'; ?>

<div style="max-width: 500px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
    <h2 style="text-align: center; color: #333;">👤 Mon Profil</h2>
    
    <?php if (!empty($message)): ?>
        <p style="text-align: center; font-weight: bold; padding: 10px; background: #f0f0f0; border-radius: 5px;">
            <?= $message ?>
        </p>
    <?php endif; ?>

    <form method="POST" style="display: flex; flex-direction: column; gap: 15px;">
        <div>
            <label style="font-weight: bold; display: block; margin-bottom: 5px;">Nom :</label>
            <input type="text" name="nom" value="<?= htmlspecialchars($user['nom']) ?>" required 
                   style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;">
        </div>

        <div>
            <label style="font-weight: bold; display: block; margin-bottom: 5px;">Email :</label>
            <input type="email" name="email" value="<?= htmlspecialchars($user['email']) ?>" required 
                   style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box;">
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 10px;">
            <a href="index.php" style="padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px;">Retour</a>
            <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">Enregistrer</button>
        </div>
    </form>
</div>

<?php require 'src/Views/layout/footer.php'; ?>