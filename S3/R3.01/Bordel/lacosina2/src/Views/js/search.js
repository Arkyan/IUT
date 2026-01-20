let recipes = [];

async function loadRecipes() {
  const URL = window.location.origin + window.location.pathname;
  const response = await fetch(URL + '?c=recette&a=indexJSON');  
  recipes = await response.json();
  console.log(recipes);
  return recipes;
}

function filterRecipes() {
  const search = document.getElementById('search').value.toLowerCase();
  const filteredRecipes = recipes.filter(recipe => recipe.titre.toLowerCase().includes(search));
  displayRecipes(filteredRecipes);
}

function displayRecipes(recipesToDisplay) {
  const resultsDiv = document.getElementById('results');
  if (!resultsDiv) return;

  resultsDiv.innerHTML = '';

  if (recipesToDisplay.length === 0) {
    resultsDiv.innerHTML = '<p>Aucune recette trouvée.</p>';
  } else {
    recipesToDisplay.forEach(recipe => {
      const recipeItem = document.createElement('div');
      recipeItem.classList.add('mb-4');
      
      const title = document.createElement('h5');
      const link = document.createElement('a');
      link.href = `?c=recette&a=detail&id=${recipe.id}`;
      link.textContent = recipe.titre;
      link.classList.add('text-primary', 'text-decoration-none');
      title.appendChild(link);
      
      const description = document.createElement('p');
      description.textContent = `Description : ${recipe.description}`;
      description.classList.add('mb-1');
      
      recipeItem.appendChild(title);
      recipeItem.appendChild(description);
      resultsDiv.appendChild(recipeItem);
    });
  }
}

document.addEventListener('DOMContentLoaded', async () => {
  await loadRecipes();
  const searchInput = document.getElementById('search');

  searchInput.addEventListener('focus', () => {
    const container = document.querySelector('.container');
    container.innerHTML = '';
    
    const title = document.createElement('h1');
    title.textContent = 'Résultats de la recherche';
    container.appendChild(title);

    const resultsDiv = document.createElement('div');
    resultsDiv.id = 'results';
    container.appendChild(resultsDiv);
    
    filterRecipes();
  });

  searchInput.addEventListener('blur', () => {
    setTimeout(() => {
      location.reload();
    }, 200);
  });

  searchInput.addEventListener('input', filterRecipes);
});