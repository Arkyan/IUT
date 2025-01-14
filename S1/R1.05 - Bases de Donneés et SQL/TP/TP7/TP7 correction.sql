CREATE TABLE EQUIPE (
	idEquipe INT PRIMARY KEY,
	idJoueur1 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur) NOT NULL,
	idJoueur2 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur) NOT NULL
)

CREATE TABLE MATCHDOUBLE (
	idEquipeGagnante INT FOREIGN KEY REFERENCES EQUIPE(idEquipe) NOT NULL,
	idEquipePerdante INT FOREIGN KEY REFERENCES EQUIPE(idEquipe) NOT NULL,
	idTournoi INT FOREIGN KEY REFERENCES TOURNOI(idTournoi) NOT NULL,
	dateMatch date NOT NULL,
)

;

--Q1
----
SELECT COUNT(*) AS NbDouble FROM MATCHDOUBLE

;

--Q2
----
(
SELECT nom, prenom, idJoueur
FROM JOUEUR JOIN MATCH M ON idJoueur=idGagnant JOIN TOURNOI T ON M.idTournoi=T.idTournoi
WHERE TOURNOI='Garros' AND dateMatch BETWEEN '01/01/2021' AND '31/12/2021'
UNION
SELECT nom, prenom, idJoueur
FROM JOUEUR JOIN MATCH M ON idJoueur=idPerdant JOIN TOURNOI T ON M.idTournoi=T.idTournoi
WHERE TOURNOI='Garros' AND dateMatch BETWEEN '01/01/2021' AND '31/12/2021'
) INTERSECT (
SELECT nom, prenom, idJoueur
FROM JOUEUR JOIN EQUIPE ON idJoueur=idJoueur1 OR idJoueur=idJoueur2
JOIN MATCHDOUBLE M ON idEquipe=idEquipeGagnante JOIN TOURNOI T ON M.idTournoi=T.idTournoi
WHERE TOURNOI='Garros' AND dateMatch BETWEEN '01/01/2021' AND '31/12/2021'
UNION
SELECT nom, prenom, idJoueur
FROM JOUEUR JOIN EQUIPE ON idJoueur=idJoueur1 OR idJoueur=idJoueur2
JOIN MATCHDOUBLE M ON idEquipe=idEquipePerdante JOIN TOURNOI T ON M.idTournoi=T.idTournoi
WHERE TOURNOI='Garros' AND dateMatch BETWEEN '01/01/2021' AND '31/12/2021'
)

;

--Q3
----
SELECT nom, prenom, count(*) AS win FROM
(
    SELECT nom, prenom FROM JOUEUR JOIN MATCH ON idJoueur=idGagnant
    UNION ALL
    SELECT nom, prenom
    FROM JOUEUR JOIN EQUIPE ON idJoueur=idJoueur1 JOIN MATCHDOUBLE ON idEquipe=idEquipeGagnante
    UNION ALL
    SELECT nom, prenom
    FROM JOUEUR JOIN EQUIPE ON idJoueur=idJoueur2 JOIN MATCHDOUBLE ON idEquipe=idEquipeGagnante
) T
GROUP BY nom, prenom
ORDER BY win DESC

;

--Q4
----
SELECT J1.nom+' '+J1.prenom AS Joueur1, J2.nom+' '+J2.prenom AS Joueur2
FROM JOUEUR J1, JOUEUR J2, 
(
    SELECT
    CASE WHEN idGagnant<idPerdant THEN idGagnant ELSE idPerdant END AS Joueur1,
    CASE WHEN idGagnant<idPerdant THEN idPerdant ELSE idGagnant END AS Joueur2
    FROM MATCH
    INTERSECT
    (
        SELECT
        CASE WHEN idJoueur1<idJoueur2 THEN idJoueur1 ELSE idJoueur2 END,
        CASE WHEN idJoueur1<idJoueur2 THEN idJoueur2 ELSE idJoueur1 END
        FROM EQUIPE JOIN MATCHDOUBLE M ON idEquipe=idEquipeGagnante
        UNION
        SELECT
        CASE WHEN idJoueur1<idJoueur2 THEN idJoueur1 ELSE idJoueur2 END,
        CASE WHEN idJoueur1<idJoueur2 THEN idJoueur2 ELSE idJoueur1 END
        FROM EQUIPE JOIN MATCHDOUBLE M ON idEquipe=idEquipePerdante
    )
) T
WHERE J1.idJoueur=T.Joueur1 AND J2.idJoueur=T.Joueur2



