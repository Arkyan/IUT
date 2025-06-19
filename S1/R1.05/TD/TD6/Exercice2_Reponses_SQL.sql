
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
SELECT DISTINCT nom, âge
FROM JOUEUR,TOURNOI,MATCH 
WHERE (idJoueur = idGagnant OR idJoueur = idPerdant)
 AND dateMatch BETWEEN '2020-01-01' AND '2020-12-31'
 AND tournoi = 'Garros';

SELECT DISTINCT nom, âge
FROM TOURNOI JOIN MATCH ON TOURNOI.idTournoi = MATCH.idTournoi
JOIN JOUEUR ON (JOUEUR.idJoueur = MATCH.idGagnant OR JOUEUR.idJoueur = MATCH.idPerdant)
WHERE YEAR(dateMatch) = 2020 
AND tournoi = 'Garros';


-- 4. Nom et nationalité des joueurs ayant remporté au moins un match dans les tournois « Garros » et « Open » :
SELECT nom, nationalité
FROM JOUEUR,TOURNOI,MATCH 
WHERE idJoueur = idGagnant 
AND TOURNOI.idTournoi = MATCH.idTournoi
AND tournoi='Garros' 
INTERSECT
SELECT nom, nationalité
FROM JOUEUR,TOURNOI,MATCH 
WHERE idJoueur = idGagnant
AND TOURNOI.idTournoi = MATCH.idTournoi
AND tournoi='Open';


-- 5. Liste des joueurs n'ayant jamais remporté de match :
SELECT nom
FROM JOUEUR 
WHERE idJoueur NOT IN ( SELECT idGagnant FROM MATCH );


-- 6. Liste des joueurs n'ayant jamais remporté de match à « Garros » :
SELECT nom
FROM JOUEUR 
WHERE idJoueur NOT IN ( SELECT idGagnant FROM MATCH WHERE idTournoi = 1 );


-- 7. Moyenne annuelle des gains pour le tournoi « Garros » avec AVG :
SELECT année, AVG(montant) AS moyenne_gains
FROM GAIN, TOURNOI
WHERE GAIN.idTournoi = TOURNOI.idTournoi
AND tournoi = 'Garros'
GROUP BY année;


-- 8. Calcul de la moyenne des gains sans AVG :
SELECT année, SUM(montant) AS Total, COUNT(idJoueur) AS NbPrimes, 
SUM(montant)/COUNT(idJoueur) AS Moyenne
FROM GAIN g JOIN TOURNOI t ON g.idTournoi = t.idTournoi
WHERE tournoi = 'Garros'
GROUP BY année;

-- 9. Nombre de matchs remportés par chaque joueur, trié par nombre de victoires :
SELECT CONCAT(J.nom, ' ', J.prénom) AS joueur, COUNT(M.idGagnant) AS victoires
FROM JOUEUR J
JOIN MATCH M ON J.idJoueur = M.idGagnant
GROUP BY joueur
ORDER BY victoires DESC;

