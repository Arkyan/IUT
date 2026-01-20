<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg">
                <div class="card-body p-5">
                    <h1 class="card-title text-center mb-4">Connexion</h1>
                    <form action="?c=user&a=connecter" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="text" class="form-control" name="email" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="pwd" class="form-label">Mot de passe</label>
                            <input type="password" class="form-control" name="pwd" id="pwd" required>
                        </div>
                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary w-100" id="connexion">
                                <i class="bi bi-box-arrow-in-right"></i> Se connecter
                            </button>
                        </div>
                    </form>
                    <hr>
                    <p class="text-center text-muted">Pas encore de compte ? 
                        <a href="?c=user&a=inscription" class="text-decoration-none">S'inscrire ici</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>