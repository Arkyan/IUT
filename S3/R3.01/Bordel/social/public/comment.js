document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form[action*="comment&a=ajouter"]');
    if (!form) return;

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(form);
        const contenuTextarea = form.querySelector('textarea[name="contenu"]');

        fetch('?c=comment&a=ajouter', {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.text().then(text => {
                try {
                    return JSON.parse(text);
                } catch (e) {
                    console.error('Réponse reçue:', text);
                    throw new Error('Réponse invalide du serveur');
                }
            });
        })
        .then(data => {
            if (data.success) {
                const commentHtml = `
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div class="flex-grow-1">
                                    <div class="d-flex align-items-center">
                                        <strong class="me-2">${escapeHtml(data.comment.auteur)}</strong>
                                        <span class="text-muted small">
                                            <i class="bi bi-calendar-event"></i> ${data.comment.date_commentaire}
                                        </span>
                                    </div>
                                </div> 
                                <a href="?c=comment&a=supprimer&id=${data.comment.id}" class="btn btn-sm btn-danger ms-2" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce commentaire ?');">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                            <p class="card-text mb-0">
                                ${escapeHtml(data.comment.contenu)}
                            </p>
                        </div>
                    </div>
                `;

                contenuTextarea.value = '';

                const commentsList = document.querySelector('.comments-list');
                if (commentsList) {
                    commentsList.insertAdjacentHTML('afterbegin', commentHtml);
                } else {
                    const alertInfo = form.parentElement.querySelector('.alert-info');
                    if (alertInfo) {
                        alertInfo.remove();
                    }
                    const newList = document.createElement('div');
                    newList.className = 'comments-list';
                    newList.innerHTML = commentHtml;
                    form.parentElement.appendChild(newList);
                }

                showNotification('Commentaire publié avec succès!', 'success');
            } else {
                showNotification(data.message || 'Erreur lors de l\'ajout du commentaire', 'danger');
            }
        })
        .catch(error => {
            console.error('Erreur:', error);
            showNotification('Erreur lors de l\'ajout du commentaire', 'danger');
        });
    });
});

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function showNotification(message, type) {
    const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    const icon = type === 'success' ? 'bi-check-circle' : 'bi-exclamation-circle';
    
    const alertHtml = `
        <div class="alert ${alertClass} alert-dismissible fade show" role="alert">
            <i class="bi ${icon}"></i> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;
    
    const container = document.querySelector('.container');
    const firstAlert = container.querySelector('.alert');
    if (firstAlert) {
        firstAlert.insertAdjacentHTML('beforebegin', alertHtml);
    } else {
        container.insertAdjacentHTML('afterbegin', alertHtml);
    }

    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const closeBtn = alert.querySelector('.btn-close');
            if (closeBtn) closeBtn.click();
        });
    }, 5000);
}
