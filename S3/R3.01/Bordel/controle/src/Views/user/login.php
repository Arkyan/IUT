<?php require 'src/Views/layout/header.php'; ?>
<h2>Connexion</h2>
<?php if(isset($error)) echo "<p style='color:red'>$error</p>"; ?>
<form method="post">
    Email: <input type="email" name="email" required><br>
    Mot de passe: <input type="password" name="password" required><br>
    <button type="submit">Se connecter</button>
</form>
<?php require 'src/Views/layout/footer.php'; ?>