<body>
  <h1>Contacts</h1>
  <div class="row">
    <?php foreach ($contacts as $contact): ?>
      <div class="col-4 p-2">
        <div class="card">
          <div class="card-body">
            <h2 class="card-title"><?php echo $contact['nom']; ?></h2>
            <a href="mailto:<?php echo $contact['email']; ?>"><?php echo $contact['email']; ?></a>
            <p class="card-text"><?php echo $contact['message']; ?></p>
          </div>
        </div> 
      </div>
    <?php endforeach; ?>
  </div>
  <a href="?c=home" class="btn btn-primary">Retour à l'accueil</a>
</body>