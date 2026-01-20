<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Réseau Social</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f4f4f4; margin: 0; padding-bottom: 50px; }
        
        nav { background: #333; color: #fff; padding: 10px 20px; margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; }
        nav a { color: #fff; text-decoration: none; margin-right: 15px; font-weight: 500; }
        nav a:hover { text-decoration: underline; }
        
        .container { width: 80%; max-width: 1000px; margin: 20px auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        
        
        .search-container {
            position: relative;
            width: 300px;
        }

        #live-search {
            width: 100%;
            padding: 8px;
            border-radius: 20px;
            border: none;
            outline: none;
            padding-left: 15px;
        }

        #search-results {
            position: absolute;
            top: 110%;
            left: 0;
            width: 100%;
            background: white;
            color: black;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            z-index: 9999;
            display: none;
            max-height: 300px;
            overflow-y: auto;
        }

        .search-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            text-align: left;
        }

        .search-item:hover {
            background-color: #f0f0f0;
        }
        
        .highlight-anim { animation: highlight 2s ease-out; }
        @keyframes highlight {
            0% { background-color: #fff3cd; }
            100% { background-color: transparent; }
        }
    </style>

    <?php if (isset($_SESSION['user_id'])): ?>
        <script>
            const user_id = <?= (int)$_SESSION['user_id'] ?>;
        </script>
    <?php endif; ?>
    
    <script src="js/script.js" defer></script>
</head>
<body>
    <nav>
        <div style="display: flex; align-items: center;">
            <a href="index.php" style="font-size: 1.2em;"><strong>Mon Réseau</strong></a>
        </div>
        
        <div class="search-container">
            <input type="text" id="live-search" placeholder="Rechercher utilisateur, message..." autocomplete="off">
            <div id="search-results"></div>
        </div>

        <div style="display: flex; align-items: center;">
            <?php if (isset($_SESSION['user_id'])): ?>
                <span style="margin-right: 15px;">Bonjour, <?php echo htmlspecialchars($_SESSION['user_nom'] ?? 'Membre'); ?></span>
                <a href="index.php?page=profile" style="margin-right: 15px; color: #add8e6;">Mon Profil</a>
                <a href="index.php?page=create_post">Publier</a>
                <a href="index.php?page=logout">Déconnexion</a>
                
               <div style="position: relative; margin-left: 10px; display: inline-block;">
                    <span id="notif-btn" style="cursor:pointer; font-size: 1.2em;">
                        🔔 
                        <span id="notif-badge" style="background:red; color:white; border-radius:50%; padding:2px 5px; font-size:0.7em; position: absolute; top: -5px; right: -5px; display:none;">0</span>
                    </span>

                    <div id="notif-dropdown" style="display: none; position: absolute; right: 0; top: 30px; background: white; border: 1px solid #ccc; width: 250px; border-radius: 5px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); z-index: 1000; color: black;">
                        <div id="notif-list" style="max-height: 200px; overflow-y: auto;">
                            </div>
                        <button id="mark-read-btn" style="width: 100%; padding: 5px; background: #007bff; color: white; border: none; cursor: pointer; display: none;">
                            Tout marquer comme lu
                        </button>
                    </div>
                </div>
            <?php else: ?>
                <a href="index.php?page=connexion">Connexion</a>
                <a href="index.php?page=inscription">Inscription</a>
            <?php endif; ?>

            
        </div>
    </nav>
    <div class="container">