<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg">
                <div class="card-body p-5">
                    <h1 class="card-title text-center mb-4">Inscription</h1>
                    <form action="?c=user&a=inscrire" method="post">
                        <div class="mb-3">
                            <label for="nom" class="form-label">Nom</label>
                            <input type="text" id="nom" name="nom" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Mot de passe</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-person-plus"></i> S'inscrire
                            </button>
                        </div>
                    </form>
                    <hr>
                    <p class="text-center text-muted">Déjà inscrit ? 
                        <a href="?c=user&a=connexion" class="text-decoration-none">Se connecter ici</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>