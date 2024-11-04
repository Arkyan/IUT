
-- Exercice 2 : Requêtes SQL

-- 1. Noms et gains des joueurs par an, triés par joueur et par année :
SELECT J.nom, G.année, G.montant
FROM JOUEUR J
JOIN GAIN G ON J.idJoueur = G.idJoueur
ORDER BY J.nom, G.année;

-- 2. Nom et âge des joueurs ayant participé au tournoi « Garros » en 2020 (avec UNION) :
SELECT J.nom, J.âge
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant
WHERE M.idTournoi = 1 AND M.dateMatch BETWEEN '2020-01-01' AND '2020-12-31'
UNION
SELECT J.nom, J.âge
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idPerdant
WHERE M.idTournoi = 1 AND M.dateMatch BETWEEN '2020-01-01' AND '2020-12-31';

-- 3. Réécriture de la requête précédente sans UNION, avec une expression booléenne :
SELECT J.nom, J.âge
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant OR J.idJoueur = M.idPerdant
WHERE M.idTournoi = 1 AND M.dateMatch BETWEEN '2020-01-01' AND '2020-12-31';

-- 4. Nom et nationalité des joueurs ayant remporté au moins un match dans les tournois « Garros » et « Open » :
SELECT J.nom, J.nationalité
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant
WHERE M.idTournoi = 1
INTERSECT
SELECT J.nom, J.nationalité
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant
WHERE M.idTournoi = 2;

-- 5. Liste des joueurs n'ayant jamais remporté de match :
SELECT J.nom
FROM JOUEUR J
WHERE J.idJoueur NOT IN (
    SELECT M.idGagnant
    FROM MATCH M
);

-- 6. Liste des joueurs n'ayant jamais remporté de match à « Garros » :
SELECT J.nom
FROM JOUEUR J
WHERE J.idJoueur NOT IN (
    SELECT M.idGagnant
    FROM MATCH M
    WHERE M.idTournoi = 1
);

-- 7. Moyenne annuelle des gains pour le tournoi « Garros » avec AVG :
SELECT G.année, AVG(G.montant) AS moyenne_gains
FROM GAIN G
WHERE G.idTournoi = 1
GROUP BY G.année;

-- 8. Calcul de la moyenne des gains sans AVG :
SELECT G.année, SUM(G.montant) / COUNT(G.montant) AS moyenne_gains
FROM GAIN G
WHERE G.idTournoi = 1
GROUP BY G.année;

-- 9. Nombre de matchs remportés par chaque joueur, trié par nombre de victoires :
SELECT CONCAT(J.nom, ' ', J.prénom) AS joueur, COUNT(M.idGagnant) AS victoires
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant
GROUP BY joueur
ORDER BY victoires DESC;

-- 10. Nom et prénom des couples de joueurs où le premier a toujours battu le second :
SELECT J1.nom AS gagnant, J1.prénom AS gagnant_prenom, J2.nom AS perdant, J2.prénom AS perdant_prenom
FROM JOUEUR J1
JOIN MATCH M ON J1.idJoueur = M.idGagnant
JOIN JOUEUR J2 ON J2.idJoueur = M.idPerdant
GROUP BY gagnant, gagnant_prenom, perdant, perdant_prenom
HAVING COUNT(DISTINCT M.idTournoi) = (SELECT COUNT(*) FROM MATCH M2 WHERE M2.idGagnant = J1.idJoueur AND M2.idPerdant = J2.idJoueur);
