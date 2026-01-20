<?php require 'src/Views/layout/header.php'; ?>
<h2>Publier un message</h2>
<form method="post">
    Titre: <input type="text" name="titre" required><br>
    Contenu: <textarea name="contenu" required></textarea><br>
    <button type="submit">Publier</button>
</form>
<?php require 'src/Views/layout/footer.php'; ?>