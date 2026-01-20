document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('searchInput');
  const searchResults = document.getElementById('searchResults');
  let searchTimeout;

  if (!searchInput) return;

  searchInput.addEventListener('input', function() {
    clearTimeout(searchTimeout);
    const query = this.value.trim();

    if (query.length < 2) {
      searchResults.innerHTML = '';
      searchResults.style.display = 'none';
      return;
    }

    searchTimeout = setTimeout(() => {
      performSearch(query);
    }, 300);
  });

  document.addEventListener('click', function(e) {
    if (!e.target.closest('.search-container')) {
      searchResults.style.display = 'none';
    }
  });

  function performSearch(query) {
    fetch(`index.php?c=search&a=liveSearch&q=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        if (data.success && data.results) {
          displayResults(data.results, query);
        } else {
          searchResults.innerHTML = '<div class="search-no-results">Aucun résultat</div>';
        }
      })
      .catch(error => {
        console.error('Erreur lors de la recherche:', error);
        searchResults.innerHTML = '<div class="search-error">Erreur lors de la recherche</div>';
      });
  }

  function displayResults(results, query) {
    let html = '';

    if (results.users && results.users.length > 0) {
      html += '<div class="search-category">';
      html += '<h6 class="search-category-title">Utilisateurs</h6>';
      results.users.forEach(user => {
        html += `<a href="index.php?c=user&a=profil&id=${user.id}" class="search-result-item">
                  <div class="search-result-content">
                    <strong>${escapeHtml(user.nom)}</strong>
                    <small class="text-muted">${escapeHtml(user.email)}</small>
                  </div>
                </a>`;
      });
      html += '</div>';
    }

    if (results.posts && results.posts.length > 0) {
      html += '<div class="search-category">';
      html += '<h6 class="search-category-title">Publications</h6>';
      results.posts.forEach(post => {
        const excerpt = post.contenu.substring(0, 60) + (post.contenu.length > 60 ? '...' : '');
        html += `<a href="index.php?c=post&a=detail&id=${post.id}" class="search-result-item">
                  <div class="search-result-content">
                    <strong>${escapeHtml(excerpt)}</strong>
                    <small class="text-muted">par ${escapeHtml(post.user_name)}</small>
                  </div>
                </a>`;
      });
      html += '</div>';
    }

    if (results.comments && results.comments.length > 0) {
      html += '<div class="search-category">';
      html += '<h6 class="search-category-title">Commentaires</h6>';
      results.comments.forEach(comment => {
        const excerpt = comment.contenu.substring(0, 60) + (comment.contenu.length > 60 ? '...' : '');
        html += `<a href="index.php?c=post&a=detail&id=${comment.post_id}" class="search-result-item">
                  <div class="search-result-content">
                    <strong>${escapeHtml(excerpt)}</strong>
                    <small class="text-muted">par ${escapeHtml(comment.user_name)}</small>
                  </div>
                </a>`;
      });
      html += '</div>';
    }

    if (!html) {
      html = '<div class="search-no-results">Aucun résultat pour "' + escapeHtml(query) + '"</div>';
    }

    searchResults.innerHTML = html;
    searchResults.style.display = 'block';
  }

  function escapeHtml(text) {
    const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
  }
});
