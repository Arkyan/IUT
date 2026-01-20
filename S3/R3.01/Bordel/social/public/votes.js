document.addEventListener('DOMContentLoaded', function() {
    initializeVoteButtons();
});

function initializeVoteButtons() {
    const voteContainers = document.querySelectorAll('.vote-container');
    
    voteContainers.forEach(container => {
        const commentId = container.getAttribute('data-comment-id');
        
        loadVoteState(commentId, container);
        
        const upvoteBtn = container.querySelector('.btn-upvote');
        const downvoteBtn = container.querySelector('.btn-downvote');
        
        if (upvoteBtn) {
            upvoteBtn.addEventListener('click', function(e) {
                e.preventDefault();
                toggleVote(commentId, 'up', container);
            });
        }
        
        if (downvoteBtn) {
            downvoteBtn.addEventListener('click', function(e) {
                e.preventDefault();
                toggleVote(commentId, 'down', container);
            });
        }
    });
}

function loadVoteState(commentId, container) {
    fetch(`?c=votes&a=getVoteCount&comment_id=${commentId}`, {
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
        updateVoteDisplay(container, data);
    })
    .catch(error => console.error('Erreur lors du chargement des votes:', error));
}

function toggleVote(commentId, voteType, container) {
    fetch('?c=votes&a=toggleVote', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            comment_id: commentId,
            vote_type: voteType
        })
    })
    .then(response => {
        if (response.status === 401) {
            alert('Veuillez vous connecter pour voter');
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
            updateVoteDisplay(container, data);
        }
    })
    .catch(error => {
        console.error('Erreur:', error);
        alert('Une erreur est survenue. Veuillez réessayer.');
    });
}

function updateVoteDisplay(container, data) {
    const upvoteBtn = container.querySelector('.btn-upvote');
    const downvoteBtn = container.querySelector('.btn-downvote');
    const scoreSpan = container.querySelector('.vote-score');
    
    if (scoreSpan) {
        scoreSpan.textContent = data.score;
    }
    
    if (upvoteBtn) {
        if (data.currentVote === 'up') {
            upvoteBtn.classList.remove('btn-outline-success');
            upvoteBtn.classList.add('btn-success');
        } else {
            upvoteBtn.classList.remove('btn-success');
            upvoteBtn.classList.add('btn-outline-success');
        }
    }
    
    if (downvoteBtn) {
        if (data.currentVote === 'down') {
            downvoteBtn.classList.remove('btn-outline-danger');
            downvoteBtn.classList.add('btn-danger');
        } else {
            downvoteBtn.classList.remove('btn-danger');
            downvoteBtn.classList.add('btn-outline-danger');
        }
    }
}
