-- Création de la table
CREATE TABLE TAB (
  nom VARCHAR(50),
  val1 INT,
  val2 INT,
  val3 INT
);

-- Insertion des données
INSERT INTO TAB VALUES
('x', 1, 3, 5),
('x', 2, 3, NULL),
('y', 4, 4, 5);

-- 1) Compter le nombre total de lignes
SELECT COUNT(*) AS Nb FROM TAB;
-- Résultat attendu : Nb = 3

-- 2) Compter le nombre de valeurs non-NULL dans val1
SELECT COUNT(val1) AS v1 FROM TAB;
-- Résultat attendu : v1 = 3

-- 3) Compter le nombre de valeurs distinctes dans la colonne nom
SELECT COUNT(DISTINCT nom) FROM TAB;
-- Résultat attendu : 2

-- 4) Compter le nombre de valeurs non-NULL dans val3
SELECT COUNT(val3) AS v3 FROM TAB;
-- Résultat attendu : v3 = 2

-- 5) Compter le nombre de valeurs non-NULL dans val1, groupé par nom
SELECT nom, COUNT(val1) AS v1 FROM TAB GROUP BY nom;
-- Résultat attendu :
-- x    | 2
-- y    | 1

-- 6) Compter le nombre de valeurs non-NULL dans val1, groupé par nom
SELECT COUNT(val1) FROM TAB GROUP BY nom;
-- Résultat attendu :
-- 2
-- 1

-- 7) Compter les valeurs distinctes dans val1 et val2, et sommer les valeurs dans val1
SELECT COUNT(DISTINCT val1) AS v1, COUNT(DISTINCT val2) AS v2, SUM(val1) AS s
FROM TAB;
-- Résultat attendu : v1 = 3, v2 = 2, s = 7

-- 8) Compter les valeurs distinctes dans val1 et val2, et sommer les valeurs dans val1, groupé par nom
SELECT COUNT(DISTINCT val1) AS v1, COUNT(DISTINCT val2) AS v2, SUM(val1) AS s
FROM TAB GROUP BY nom;
-- Résultat attendu :
-- x    | 2 | 1 | 3
-- y    | 1 | 1 | 4

-- 9) Compter le nombre de valeurs distinctes dans val3
SELECT COUNT(DISTINCT val3) FROM TAB;
-- Résultat attendu : 1
