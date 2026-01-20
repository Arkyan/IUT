document.addEventListener('DOMContentLoaded', function() {
    initializeLikeButtons();
});

function initializeLikeButtons() {
    const likeButtons = document.querySelectorAll('.btn-like');
    
    likeButtons.forEach(button => {
        const postId = button.getAttribute('data-post-id');
        
        loadLikeState(postId, button);
        
        button.addEventListener('click', function(e) {
            e.preventDefault();
            toggleLike(postId, button);
        });
    });
}

function loadLikeState(postId, button) {
    fetch(`?c=likes&a=getLikeCount&post_id=${postId}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
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
        const likeCount = data.likeCount;
        const isLiked = data.isLiked;
        
        const likeCountSpan = button.querySelector('.like-count');
        if (likeCountSpan) {
            likeCountSpan.textContent = likeCount;
        }
        
        updateButtonStyle(button, isLiked, likeCount);
    })
    .catch(error => console.error('Erreur lors du chargement des likes:', error));
}

function toggleLike(postId, button) {
    fetch('?c=likes&a=toggleLike', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            post_id: postId
        })
    })
    .then(response => {
        if (response.status === 401) {
            alert('Veuillez vous connecter pour liker un post');
            window.location.href = '?c=user&a=connexion';
            return null;
        }
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
        if (data) {
            const likeCount = data.likeCount;
            const liked = data.liked;
            
            const likeCountSpan = button.querySelector('.like-count');
            if (likeCountSpan) {
                likeCountSpan.textContent = likeCount;
            }
            
            updateButtonStyle(button, liked, likeCount);
        }
    })
    .catch(error => {
        console.error('Erreur:', error);
        alert('Une erreur est survenue. Veuillez réessayer.');
    });
}

function updateButtonStyle(button, isLiked, likeCount) {
    if (isLiked) {
        button.classList.add('liked');
        button.classList.remove('btn-outline-danger');
        button.classList.add('btn-danger');
    } else {
        button.classList.remove('liked');
        button.classList.remove('btn-danger');
        button.classList.add('btn-outline-danger');
    }
}
