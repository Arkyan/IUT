-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 11 déc. 2025 à 07:08
-- Version du serveur : 9.1.0
-- Version de PHP : 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `mon_reseau_social`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contenu` text NOT NULL,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `contenu`, `user_id`, `post_id`, `created_at`) VALUES
(1, 'jdajda', 1, 2, '2025-12-10 18:15:53'),
(2, 'adda', 1, 2, '2025-12-10 18:15:57'),
(3, 'da', 1, 7, '2025-12-10 18:31:49'),
(4, 'dad', 1, 5, '2025-12-10 18:51:06'),
(5, 'ada', 1, 8, '2025-12-10 18:51:37'),
(6, 'ada', 1, 9, '2025-12-10 18:52:04'),
(7, 'ada', 3, 9, '2025-12-10 18:52:14'),
(8, 'cac', 1, 9, '2025-12-10 18:55:37'),
(9, 'caca', 1, 9, '2025-12-10 18:55:39'),
(10, 'dad', 3, 7, '2025-12-10 19:04:43'),
(11, 'ssad', 3, 11, '2025-12-10 19:12:13'),
(12, 'saad', 3, 11, '2025-12-10 19:15:28'),
(13, 'da', 3, 10, '2025-12-10 19:15:46'),
(14, 'dada', 3, 9, '2025-12-10 19:15:56');

-- --------------------------------------------------------

--
-- Structure de la table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
CREATE TABLE IF NOT EXISTS `comment_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `comment_id` int NOT NULL,
  `vote_type` enum('up','down') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_comment_vote` (`user_id`,`comment_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `comment_likes`
--

INSERT INTO `comment_likes` (`id`, `user_id`, `comment_id`, `vote_type`, `created_at`) VALUES
(1, 1, 0, 'down', '2025-12-10 18:15:58'),
(2, 3, 2, 'down', '2025-12-10 18:25:50'),
(3, 3, 1, 'up', '2025-12-10 18:25:52'),
(4, 1, 1, 'up', '2025-12-10 18:31:12'),
(5, 1, 2, 'down', '2025-12-10 18:38:50'),
(6, 1, 6, 'up', '2025-12-10 18:52:53'),
(7, 1, 7, 'up', '2025-12-10 18:52:54'),
(8, 3, 6, 'up', '2025-12-10 19:04:26'),
(9, 3, 8, 'up', '2025-12-10 19:04:33'),
(10, 3, 3, 'up', '2025-12-10 19:09:09'),
(11, 3, 11, 'up', '2025-12-10 19:15:31'),
(12, 3, 12, 'up', '2025-12-10 19:15:33');

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `message` text NOT NULL,
  `lu` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `lu`, `created_at`) VALUES
(1, 1, 'roro a commenté votre publication.', 1, '2025-12-10 19:15:56');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Clé primaire unique du message',
  `titre` varchar(255) NOT NULL,
  `contenu` text NOT NULL,
  `utilisateur_id` int NOT NULL COMMENT 'Clé étrangère vers la table users',
  `date_publication` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date et heure de publication du message',
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table stockant les messages publiés par les utilisateurs';

-- --------------------------------------------------------

--
-- Structure de la table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
CREATE TABLE IF NOT EXISTS `post_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_post_like` (`user_id`,`post_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `post_likes`
--

INSERT INTO `post_likes` (`id`, `user_id`, `post_id`, `created_at`) VALUES
(20, 1, 3, '2025-12-10 18:14:57'),
(26, 3, 7, '2025-12-10 18:30:53'),
(18, 3, 3, '2025-12-10 18:14:33'),
(27, 3, 5, '2025-12-10 18:30:55');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Clé primaire unique',
  `nom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL COMMENT 'L’email doit être unique',
  `password` varchar(255) NOT NULL COMMENT 'Mot de passe haché',
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date et heure de création du compte',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Table stockant les informations des utilisateurs';

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `email`, `password`, `date_inscription`) VALUES
(1, 'yaya', 'yaya@yaya', '$2y$10$0aEH5xt6rB7CVFmw.8p7cO.iyOO12oPBv6.ROGELI9Uzu1K10WlJG', '2025-12-10 13:49:12'),
(3, 'roro', 'roro@roro', '$2y$10$k1V/bjjfRz297HERikrpYurYYGfTEXFi/E7PC6ZIrh6MxqPWuZqs2', '2025-12-10 14:10:20');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
