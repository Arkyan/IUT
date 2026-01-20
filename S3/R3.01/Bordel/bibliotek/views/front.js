document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('form').forEach(function (form) {
    form.addEventListener('submit', function (e) {
      var isbnInput = form.querySelector('#isbn');
      if (isbnInput) {
        var val = isbnInput.value.trim();
        if (val.length !== 13) {
          e.preventDefault();
          var err = form.querySelector('.isbn-error');
          if (!err) {
            err = document.createElement('div');
            err.className = 'isbn-error alert alert-danger mt-2';
            isbnInput.parentNode.appendChild(err);
          }
          err.textContent = 'L\'ISBN doit contenir exactement 13 caractères.';
          isbnInput.focus();
          return false;
        }
      }
    });
  });

  document.querySelectorAll('.card').forEach(function (card) {
    card.addEventListener('mouseenter', function () {
      card.dataset.originalBg = card.style.backgroundColor || '';
      card.style.backgroundColor = '#f3ceedff';
      card.style.transition = 'background-color 0.2s ease';
    });
    card.addEventListener('mouseleave', function () {
      card.style.backgroundColor = card.dataset.originalBg;
    });
  });

  document.querySelectorAll('.clickable-card').forEach(function (card) {
    card.style.cursor = 'pointer';
    card.addEventListener('click', function (e) {
      var target = e.target;
      if (target.closest('a') || target.closest('button')) {
        return;
      }
      var href = card.getAttribute('data-href');
      if (href) {
        window.location.href = href;
      }
    });
  });
});
