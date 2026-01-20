# Social Network Application

Une application de réseau social simple construite avec PHP, MySQL et JavaScript vanilla.

## Vue d'ensemble

Ce projet est une plateforme de partage social permettant aux utilisateurs de :
- Créer des comptes et se connecter
- Publier des messages (posts)
- Commenter les posts
- Liker et voter sur le contenu
- Rechercher d'autres utilisateurs
- Gérer les notifications
- Consulter les profils utilisateurs
- Sauvegarder des posts

## Structure du projet

```
social/                       # Racine du projet
├── app/                      # Code source de l'application
│   ├── controllers/          # Contrôleurs MVC
│   ├── models/               # Modèles de données
│   └── views/                # Vues
├── public/                   # Fichiers statiques
├── vendor/                   # Dépendances Composer
├── composer.json             # Configuration Composer
├── index.php                 # Point d'entrée
└── README.md                 # Documentation
```

## Architecture

### Routage
Le routage est géré via `index.php` avec les paramètres URL :
- `?c=controller` : Désigne le contrôleur (post, user, comment, etc.)
- `?a=action` : Désigne l'action à exécuter

**Exemple** : `?c=post&a=detail&id=1` → affiche le détail du post #1

### Requêtes AJAX
Les requêtes asynchrones (like/votes/recherche) ne chargent pas le header et retournent du JSON.

## Base de données

La base s'appelle `social` et contient les tables principales :
- `users` : Profils utilisateurs
- `posts` : Messages publiés
- `comments` : Commentaires
- `post_likes` : Likes sur les posts
- `comment_likes` : Likes sur les commentaires
- `notifications` : Notifications utilisateurs

Configuration dans `app/models/Database.php`

## Installation

1. **Prérequis** : PHP 7.x+, MySQL, Composer

2. **Cloner/télécharger** le projet dans Wamp ou autre serveur local.

3. **Configurer la base de données** :
   - Utiliser le fichier `database.sql` dans PHPMyAdmin pour créer les tables et la base `social`.

4. **Accéder** : `http://localhost/social/`

## Fonctionnalités principales

### Utilisateurs
- Inscription et connexion
- Gestion de profil
- Page profil utilisateur

### Posts
- Créer un post
- Afficher tous les posts
- Voir détail d'un post
- Éditer ses posts
- Supprimer ses posts

### Commentaires
- Ajouter un commentaire sur un post
- Éditer ses commentaires
- Supprimer ses commentaires
  
### Interactions
- Liker/déliker les posts
- Upvote/Downvote les commentaires
- Système de notifications

### Recherche
- Rechercher des utilisateurs, posts, commentaires en temps réel.

## Frontend

- **JavaScript vanilla** pour l'interactivité (sans framework)
- **CSS personnalisé** avec support du mode sombre (theme-toggle)
- **Bootstrap 5** pour la mise en page responsive
- **AJAX** pour les actions sans rechargement

**Fichiers JS** :
- `comment.js` / `comment-edit.js` : Gestion des commentaires et de leur édition INLINE
- `likes.js` : Système de likes
- `votes.js` : Système de votes
- `search.js` : Recherche utilisateurs, posts et commentaires
- `notifications.js` : Notifications en temps réel

## Sécurité
- Utilisation de **PDO** pour prévenir les injections SQL
- Gestion des sessions PHP (`session_start()`)
- Contrôles d'accès (vérification de connexion) pour les créations/modifications/suppressions de contenu

## Auteur
Jules Didry & Yael Betton

## Namespace Composer
L'autoloading Composer :
- `App\R301\`
- `App\R301\Controller\`
- `App\R301\Model\`
