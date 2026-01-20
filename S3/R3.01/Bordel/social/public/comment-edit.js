document.addEventListener('DOMContentLoaded', function() {
    initializeInlineEdit();
});

function initializeInlineEdit() {
    const editButtons = document.querySelectorAll('.btn-edit-comment');
    
    editButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const commentId = this.getAttribute('data-comment-id');
            enableEditMode(commentId);
        });
    });
}

function enableEditMode(commentId) {
    const commentCard = document.querySelector(`[data-comment-card="${commentId}"]`);
    if (!commentCard) return;
    
    const contentElement = commentCard.querySelector('.comment-content');
    const editButton = commentCard.querySelector('.btn-edit-comment');
    const originalContent = contentElement.textContent.trim();
    
    contentElement.setAttribute('data-original-content', originalContent);
    
    contentElement.setAttribute('contenteditable', 'true');
    contentElement.classList.add('editing', 'border', 'border-primary', 'rounded', 'p-2');
    contentElement.focus();
    
    if (editButton) {
        editButton.style.display = 'none';
    }
    
    const controlsDiv = document.createElement('div');
    controlsDiv.className = 'edit-controls mt-2';
    controlsDiv.innerHTML = `
        <button class="btn btn-sm btn-success me-2" onclick="saveComment(${commentId})">
            <i class="bi bi-check-lg"></i> Enregistrer
        </button>
        <button class="btn btn-sm btn-secondary" onclick="cancelEdit(${commentId})">
            <i class="bi bi-x-lg"></i> Annuler
        </button>
    `;
    contentElement.parentElement.appendChild(controlsDiv);
    
    let blurTimeout;
    contentElement.addEventListener('blur', function(e) {
        blurTimeout = setTimeout(() => {
            if (!e.relatedTarget || !e.relatedTarget.closest('.edit-controls')) {
                saveComment(commentId);
            }
        }, 200);
    });
    
    controlsDiv.addEventListener('mousedown', function(e) {
        clearTimeout(blurTimeout);
    });
    
    contentElement.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            saveComment(commentId);
        }
        if (e.key === 'Escape') {
            e.preventDefault();
            cancelEdit(commentId);
        }
    });
}

function saveComment(commentId) {
    const commentCard = document.querySelector(`[data-comment-card="${commentId}"]`);
    if (!commentCard) return;
    
    const contentElement = commentCard.querySelector('.comment-content');
    const newContent = contentElement.textContent.trim();
    const originalContent = contentElement.getAttribute('data-original-content');
    
    if (newContent === originalContent) {
        cancelEdit(commentId);
        return;
    }
    
    if (!newContent) {
        alert('Le commentaire ne peut pas être vide');
        contentElement.textContent = originalContent;
        contentElement.focus();
        return;
    }
    
    contentElement.setAttribute('contenteditable', 'false');
    contentElement.classList.add('opacity-50');
    
    fetch('?c=comment&a=modifier', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            comment_id: commentId,
            contenu: newContent
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur réseau: ' + response.status);
        }
        const contentType = response.headers.get("content-type");
        if (!contentType || !contentType.includes("application/json")) {
            return response.text().then(text => {
                console.error('Réponse non-JSON reçue:', text);
                throw new Error('La réponse n\'est pas du JSON');
            });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            disableEditMode(commentId);
            
            contentElement.classList.add('bg-success', 'bg-opacity-10');
            setTimeout(() => {
                contentElement.classList.remove('bg-success', 'bg-opacity-10');
            }, 1000);
        } else {
            throw new Error(data.error || 'Erreur lors de la sauvegarde');
        }
    })
    .catch(error => {
        console.error('Erreur:', error);
        alert('Erreur lors de la modification du commentaire: ' + error.message);
        contentElement.textContent = originalContent;
        disableEditMode(commentId);
    });
}

function cancelEdit(commentId) {
    const commentCard = document.querySelector(`[data-comment-card="${commentId}"]`);
    if (!commentCard) return;
    
    const contentElement = commentCard.querySelector('.comment-content');
    const originalContent = contentElement.getAttribute('data-original-content');
    
    contentElement.textContent = originalContent;
    
    disableEditMode(commentId);
}

function disableEditMode(commentId) {
    const commentCard = document.querySelector(`[data-comment-card="${commentId}"]`);
    if (!commentCard) return;
    
    const contentElement = commentCard.querySelector('.comment-content');
    const editButton = commentCard.querySelector('.btn-edit-comment');
    const controlsDiv = commentCard.querySelector('.edit-controls');
    
    contentElement.setAttribute('contenteditable', 'false');
    contentElement.classList.remove('editing', 'border', 'border-primary', 'rounded', 'p-2', 'opacity-50');
    contentElement.removeAttribute('data-original-content');
    
    if (editButton) {
        editButton.style.display = '';
    }
    
    if (controlsDiv) {
        controlsDiv.remove();
    }
}

window.saveComment = saveComment;
window.cancelEdit = cancelEdit;
