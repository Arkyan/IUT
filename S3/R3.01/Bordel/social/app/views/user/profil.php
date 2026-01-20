<?php
if (!isset($user) || !$user) {
    echo "Utilisateur non trouvé.";
    exit();
}
?>

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white">
                    <h2>Profil Utilisateur</h2>
                </div>
                <div class="card-body">
                    <div class="profile-section">
                        <h4 class="mb-4"><?php echo htmlspecialchars($user['nom']); ?></h4>
                        
                        <div class="profile-info">
                            <p><strong>Email:</strong> <span class="badge bg-info"><?php echo htmlspecialchars($user['email']); ?></span></p>
                        </div>

                        <hr>

                        <div class="profile-actions">
                            <a href="?c=home" class="btn btn-secondary">
                                <i class="bi bi-house"></i> Retour à l'accueil
                            </a>
                            <a href="?c=post&a=index" class="btn btn-primary">
                                <i class="bi bi-journal-text"></i> Voir les publications
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.profile-section {
    padding: 20px;
}

.profile-info {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
}

.profile-info p {
    margin-bottom: 10px;
    font-size: 16px;
}

.profile-actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.profile-actions .btn {
    flex: 1;
    min-width: 150px;
}

@media (max-width: 576px) {
    .profile-actions {
        flex-direction: column;
    }

    .profile-actions .btn {
        width: 100%;
    }
}
</style>
