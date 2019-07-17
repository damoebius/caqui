-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Hôte : taminaoncaqui.mysql.db
-- Généré le :  mer. 17 juil. 2019 à 10:03
-- Version du serveur :  5.6.43-log
-- Version de PHP :  7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `caquidb`
--

-- --------------------------------------------------------

--
-- Structure de la table `game`
--

CREATE TABLE `game` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `current_id_player` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `game`
--

INSERT INTO `game` (`id`, `current_id_player`, `name`, `enabled`) VALUES
(1, 1, 'C\'est partyyyy', 1),
(2, 3, 'Map à 3', 1);

-- --------------------------------------------------------

--
-- Structure de la table `game_member`
--

CREATE TABLE `game_member` (
  `id_game` smallint(5) UNSIGNED NOT NULL,
  `id_player` smallint(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `game_member`
--

INSERT INTO `game_member` (`id_game`, `id_player`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2),
(1, 3),
(2, 3),
(1, 4);

-- --------------------------------------------------------

--
-- Structure de la table `player`
--

CREATE TABLE `player` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `player`
--

INSERT INTO `player` (`id`, `name`, `email`) VALUES
(1, 'damo', 'david@tamina.io'),
(2, 'paul', 'rochon.paul@gmail.com'),
(3, 'titom', 'titom@tamina-online.com'),
(4, 'sylco', 'sylvain.coulonges@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `turn`
--

CREATE TABLE `turn` (
  `id_game` smallint(5) UNSIGNED NOT NULL,
  `turn` smallint(6) NOT NULL,
  `id_player` smallint(5) UNSIGNED NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_game_currentplayer` (`current_id_player`);

--
-- Index pour la table `game_member`
--
ALTER TABLE `game_member`
  ADD UNIQUE KEY `id_game` (`id_game`,`id_player`),
  ADD KEY `fk_playerid` (`id_player`);

--
-- Index pour la table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `turn`
--
ALTER TABLE `turn`
  ADD UNIQUE KEY `id_game` (`id_game`,`turn`),
  ADD KEY `fk_turn_playerid` (`id_player`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `game`
--
ALTER TABLE `game`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `player`
--
ALTER TABLE `player`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `fk_game_currentplayer` FOREIGN KEY (`current_id_player`) REFERENCES `player` (`id`);

--
-- Contraintes pour la table `game_member`
--
ALTER TABLE `game_member`
  ADD CONSTRAINT `fk_gameid` FOREIGN KEY (`id_game`) REFERENCES `game` (`id`),
  ADD CONSTRAINT `fk_playerid` FOREIGN KEY (`id_player`) REFERENCES `player` (`id`);

--
-- Contraintes pour la table `turn`
--
ALTER TABLE `turn`
  ADD CONSTRAINT `fk_turn_gameid` FOREIGN KEY (`id_game`) REFERENCES `game` (`id`),
  ADD CONSTRAINT `fk_turn_playerid` FOREIGN KEY (`id_player`) REFERENCES `player` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
