document.addEventListener('DOMContentLoaded', function() {
  const themeToggle = document.getElementById('themeToggle');
  const htmlElement = document.documentElement;
  const themeKey = 'theme-preference';

  function initializeTheme() {
    const savedTheme = localStorage.getItem(themeKey);
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

    const theme = savedTheme || (prefersDark ? 'dark' : 'light');
    applyTheme(theme);
  }

  function applyTheme(theme) {
    if (theme === 'dark') {
      htmlElement.setAttribute('data-theme', 'dark');
      updateToggleIcon('sun');
      localStorage.setItem(themeKey, 'dark');
    } else {
      htmlElement.removeAttribute('data-theme');
      updateToggleIcon('moon');
      localStorage.setItem(themeKey, 'light');
    }
  }

  function updateToggleIcon(icon) {
    const iconElement = themeToggle.querySelector('i');
    if (icon === 'sun') {
      iconElement.classList.remove('bi-moon-fill');
      iconElement.classList.add('bi-sun-fill');
      themeToggle.title = 'Passer en mode clair';
    } else {
      iconElement.classList.remove('bi-sun-fill');
      iconElement.classList.add('bi-moon-fill');
      themeToggle.title = 'Passer en mode sombre';
    }
  }

  themeToggle.addEventListener('click', function(e) {
    e.preventDefault();
    
    const currentTheme = htmlElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    applyTheme(newTheme);
  });

  const darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');
  darkModeQuery.addEventListener('change', (e) => {
    const savedTheme = localStorage.getItem(themeKey);
    if (!savedTheme) {
      applyTheme(e.matches ? 'dark' : 'light');
    }
  });
  
  initializeTheme();
});
