CREATE TABLE MATCHDOUBLE (
    idGagnant1 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur),
    idGagnant2 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur),
    idPerdant1 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur),
    idPerdant2 INT FOREIGN KEY REFERENCES JOUEUR(idJoueur),
    idTournoi INT FOREIGN KEY REFERENCES TOURNOI(idTournoi),
    dateMatch DATE,
)
-------------------------------------------------------

INSERT INTO MATCHDOUBLE VALUES (1,2,3,4,3,'31/12/2018');
INSERT INTO MATCHDOUBLE VALUES (1,3,5,4,2,'21/12/2019');
INSERT INTO MATCHDOUBLE VALUES (2,4,3,5,1,'05/10/2020');
INSERT INTO MATCHDOUBLE VALUES (3,4,1,5,2,'30/01/2022');
INSERT INTO MATCHDOUBLE VALUES (4,5,1,2,3,'19/07/2021');
INSERT INTO MATCHDOUBLE VALUES (4,2,1,3,2,'26/08/2024');
-------------------------------------------------
SELECT COUNT(dateMatch) FROM MATCHDOUBLE

-----------------------------------------------

SELECT DISTINCT nom, prenom FROM JOUEUR,TOURNOI,MATCH,MATCHDOUBLE
WHERE (idJoueur=idGagnant OR idJoueur=idPerdant) AND TOURNOI.idTournoi = 1
 AND (MATCH.dateMatch BETWEEN '2021-01-01' AND '2021-12-31')
 AND (MATCHDOUBLE.dateMatch BETWEEN '2021-01-01' AND '2021-12-31')
 AND (idJoueur=idGagnant1 OR idJoueur=idGagnant2 OR idJoueur=idPerdant1 OR idJoueur=idPerdant2)


 -----------------------------------------------------------
SELECT nom, prenom, COUNT(idGagnant) AS VICTOIRES
FROM MATCH,JOUEUR
WHERE MATCH.idGagnant = JOUEUR.idJoueur
GROUP BY nom,prenom

UNION

SELECT nom, prenom, COUNT(idGagnant1)
FROM MATCHDOUBLE,JOUEUR
WHERE MATCHDOUBLE.idGagnant1 = JOUEUR.idJoueur
GROUP BY nom,prenom

UNION

SELECT nom, prenom, COUNT(idGagnant2)
FROM MATCHDOUBLE,JOUEUR
WHERE MATCHDOUBLE.idGagnant2 = JOUEUR.idJoueur
GROUP BY nom,prenom

SELECT * FROM MATCHDOUBLE

--------------------------------------------------

