// Fonction pour initialiser les événements des recettes
function initRecipeEvents() {
    // Événements pour les boutons d'édition
    document.querySelectorAll('.edit-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            const recetteId = this.dataset.id;
            window.location.href = `?c=recette&a=modifier&id=${recetteId}`;
        });
    });

    // Événements pour les boutons favoris
    document.querySelectorAll('.favorite-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            const recetteId = this.dataset.id;
            fetch(`?c=favoris&a=toggle&recette_id=${recetteId}&x`, {
                method: 'POST',
            })
                .then(response => response.json())
                .then(data => {
                    location.reload();
                });
        });
    });

    // Événements pour les cartes recette
    document.querySelectorAll('.recipe.card').forEach(card => {
        card.addEventListener('mouseenter', function () {
            this.classList.add('bg-primary-subtle');
        });

        card.addEventListener('mouseleave', function () {
            this.classList.remove('bg-primary-subtle');
        });

        card.addEventListener('click', function () {
            const recetteId = this.dataset.id;
            window.location.href = `?c=recette&a=detail&id=${recetteId}`;
        });
    });
}

// Gestion des filtres
function initFilterEvents() {
    const filterCards = document.querySelectorAll('.filter-card');
    console.log('initFilterEvents: Found ' + filterCards.length + ' filter cards');
    
    filterCards.forEach(card => {
        card.addEventListener('mouseenter', function () {
            this.classList.add('bg-primary-subtle');
        });

        card.addEventListener('mouseleave', function () {
            if (!this.classList.contains('active')) {
                this.classList.remove('bg-primary-subtle');
            }
        });

        card.addEventListener('click', function () {
            console.log('Filter clicked:', this.dataset.filter);
            const filter = this.dataset.filter;

            // Retirer la classe active de tous les cartes
            document.querySelectorAll('.filter-card').forEach(c => {
                c.classList.remove('bg-primary-subtle', 'active');
            });

            // Ajouter la classe active à la carte cliquée
            this.classList.add('bg-primary-subtle', 'active');

            // Charger les recettes filtrées
            filterRecipes(filter);
        });
    });
}

function filterRecipes(filter) {
    console.log('filterRecipes called with filter:', filter);
    fetch(`?c=recette&a=index&filtre=${filter}&x`)
        .then(response => {
            if(!response.ok) {
                throw new Error('HTTP error! status: ' + response.status);
            }
            return response.text();
        })
        .then(html => {
            console.log('Received HTML response');
            // Parser le HTML pour extraire la div listeRecettes
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const newList = doc.getElementById('listeRecettes');

            if (newList) {
                const currentList = document.getElementById('listeRecettes');
                if (currentList) {
                    currentList.innerHTML = newList.innerHTML;
                    console.log('Updated listeRecettes successfully');
                    // Réinitialiser les événements après la mise à jour du DOM
                    initRecipeEvents();
                } else {
                    console.error('Élément listeRecettes introuvable dans la page actuelle');
                }
            } else {
                console.error('Élément listeRecettes introuvable dans la réponse AJAX');
                console.log('HTML reçu:', html.substring(0, 500));
            }
        })
        .catch(error => console.error('Erreur lors du filtre des recettes:', error));
}

// Gestion de la section commentaires (pour la page détail)
function initCommentEvents() {
    const commentArea = document.getElementById('comment_area');
    const toggleCommentSectionButton = document.getElementById('toggleCommentSection');

    if (toggleCommentSectionButton) {
        toggleCommentSectionButton.addEventListener('click', function () {
            if (commentArea.hasAttribute('hidden')) {
                toggleCommentSectionButton.hidden = true;
                commentArea.removeAttribute('hidden');
            } else {
                toggleCommentSectionButton.textContent = 'Ajouter un commentaire';
                commentArea.setAttribute('hidden', 'true');
            }
        });
    }
}

// Initialiser les événements au chargement de la page
document.addEventListener('DOMContentLoaded', function () {
    console.log('DOMContentLoaded fired');
    
    // Pour la page de liste des recettes
    const listeRecettes = document.getElementById('listeRecettes');
    console.log('listeRecettes element found:', !!listeRecettes);
    
    if (listeRecettes) {
        initRecipeEvents();
        initFilterEvents();
        const filterCards = document.querySelectorAll('.filter-card');
        console.log('Total filter cards:', filterCards.length);
    }

    // Pour la page de détail
    if (document.getElementById('comment_area') || document.getElementById('toggleCommentSection')) {
        initCommentEvents();
    }
});