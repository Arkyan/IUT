<?php require 'src/Views/layout/header.php'; ?>
<h2>Inscription</h2>
<form method="post">
    Nom: <input type="text" name="nom" required><br>
    Email: <input type="email" name="email" required><br>
    Mot de passe: <input type="password" name="password" required><br>
    <button type="submit">S'inscrire</button>
</form>
<?php require 'src/Views/layout/footer.php'; ?>