CREATE TABLE ANIMATEUR (
    idAnimateur INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    age INT
)

CREATE TABLE STAND (
    idStand INT PRIMARY KEY NOT NULL,
    nbPersonnesMax INT,
)

CREATE TABLE ENTREPRISE (
    idEntreprise INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100),
    adresse VARCHAR(100),
    nbEmployes INT
)

CREATE TABLE PARTICIPANT (
    idParticipant INT PRIMARY KEY NOT NULL,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    idEntreprise INT FOREIGN KEY REFERENCES ENTREPRISE(idEntreprise) NOT NULL,
)

CREATE TABLE ANIMATION(
    idAnimation INT PRIMARY KEY NOT NULL,
    idStand INT FOREIGN KEY REFERENCES STAND(idStand) NOT NULL,
    idAnimateur INT FOREIGN KEY REFERENCES ANIMATEUR(idAnimateur) NOT NULL,
    titre VARCHAR(100),
    dateAnimation DATE,
    Heure TIME,
)

CREATE TABLE PARTICIPE (
    idAnimation INT NOT NULL,
    idParticipant INT NOT NULL,
)

ALTER TABLE PARTICIPE
ADD CONSTRAINT PK_PARTICIPE PRIMARY KEY (idAnimation,idParticipant);

ALTER TABLE PARTICIPE
ADD CONSTRAINT FK_PARTICIPE_Animation
FOREIGN KEY (idAnimation)
REFERENCES ANIMATION(idAnimation)

ALTER TABLE PARTICIPE
ADD CONSTRAINT FK_PARTICIPE_Participant
FOREIGN KEY (idParticipant)
REFERENCES PARTICIPANT(idParticipant)


----------------------------------------------------------

INSERT INTO ANIMATEUR VALUES (1,'Martin','Mike',18)
INSERT INTO ANIMATEUR VALUES (2,'William','Joe',32)
INSERT INTO ANIMATEUR VALUES (3,'Buck','Bill',19)
INSERT INTO ANIMATEUR VALUES (4,'Dario','Albert',25)
INSERT INTO ANIMATEUR VALUES (5,'Mora','Peter',29)

INSERT INTO STAND VALUES(111,20)
INSERT INTO STAND VALUES(222,50)
INSERT INTO STAND VALUES(333,30)
INSERT INTO STAND VALUES(444,100)

INSERT INTO ENTREPRISE VALUES (10,'Microsoft','Paris',500)
INSERT INTO ENTREPRISE VALUES (20,'Apple','Limoges',200)
INSERT INTO ENTREPRISE VALUES (30,'Mécano','Paris',15)

INSERT INTO PARTICIPANT VALUES (1,'Toto','Limoges',10)
INSERT INTO PARTICIPANT VALUES (2,'Tata','Paris',10)
INSERT INTO PARTICIPANT VALUES (3,'Titi','Limoges',10)
INSERT INTO PARTICIPANT VALUES (4,'Tutu','Paris',10)
INSERT INTO PARTICIPANT VALUES (5,'Tato','Limoges',20)
INSERT INTO PARTICIPANT VALUES (6,'Tatu','Paris',20)
INSERT INTO PARTICIPANT VALUES (7,'Tito','Limoges',20)
INSERT INTO PARTICIPANT VALUES (8,'Toti','Limoges',30)
INSERT INTO PARTICIPANT VALUES (9,'Tota','Limoges',30)

INSERT INTO ANIMATION VALUES (1,111,2,'Forum','17/12/2020','07:59:00')
INSERT INTO ANIMATION VALUES (2,222,3,'JPO','31/12/2021','18:30:00')
INSERT INTO ANIMATION VALUES (3,444,5,'Rien','31/12/2021','12:30:00')
INSERT INTO ANIMATION VALUES (4,111,2,'Forum','17/12/2021','07:50:00')
INSERT INTO ANIMATION VALUES (5,111,3,'Forum','17/11/2021','18:54:00')

INSERT INTO PARTICIPE VALUES(1,1)
INSERT INTO PARTICIPE VALUES(1,2)
INSERT INTO PARTICIPE VALUES(1,3)
INSERT INTO PARTICIPE VALUES(1,4)
INSERT INTO PARTICIPE VALUES(1,5)
INSERT INTO PARTICIPE VALUES(2,6)
INSERT INTO PARTICIPE VALUES(2,7)
INSERT INTO PARTICIPE VALUES(2,1)
INSERT INTO PARTICIPE VALUES(2,2)
INSERT INTO PARTICIPE VALUES(3,2)
INSERT INTO PARTICIPE VALUES(3,4)
INSERT INTO PARTICIPE VALUES(3,8)


--------------------------------------------------

Q1 : -- 1. Nom et prénom des animateurs de moins de 25 ans

SELECT nom,prenom FROM ANIMATEUR
WHERE age < 25

----------------------------------------------------

Q2 : -- 2. Numéro des stands triés en fonction de leur contenance, du plus grand au plus petit.

SELECT idStand FROM STAND
ORDER BY nbPersonnesMax DESC

----------------------------------------------------

Q3 : -- 3. Numéro et titre des animations se déroulant le 31 décembre 2021 entre 12 heures et 19 heures

SELECT idAnimation, titre FROM ANIMATION
WHERE dateAnimation = '31/12/2021'
AND Heure BETWEEN '12:00:00' AND '19:00:00'

---------------------------------------------------

Q4 : -- 4. Liste des participants appartenant à l’entreprise Mécano ayant déjà assisté à une animation

SELECT PARTICIPANT.nom FROM PARTICIPANT
JOIN ENTREPRISE ON ENTREPRISE.idEntreprise = PARTICIPANT.idEntreprise

WHERE ENTREPRISE.nom = 'Mécano'

----------------------------------------------------

Q5 : -- 5. Nombre total de personnes ayant participé à l’animation « JPO ».

SELECT COUNT(idParticipant) FROM PARTICIPE
JOIN ANIMATION ON PARTICIPE.idAnimation = ANIMATION.idAnimation

WHERE ANIMATION.titre = 'JPO'

------------------------------------------------------

Q6 : -- 6. Nombre de personnes différentes ayant animé la conférence « Forum ».

SELECT DISTINCT nom,prenom FROM ANIMATEUR
JOIN ANIMATION ON ANIMATEUR.idAnimateur = ANIMATION.idAnimateur

WHERE ANIMATION.titre = 'Forum'

-------------------------------------------------------

Q7 : -- 7. Numéro des stands utilisés au moins une fois en 2021

SELECT DISTINCT STAND.idStand FROM STAND
JOIN ANIMATION ON STAND.idStand = ANIMATION.idStand

WHERE dateAnimation BETWEEN '1/01/2021' AND '31/12/2021'

------------------------------------------------------

Q8 : -- 8. Nombre des personnes différentes (participants et animateurs) accueillies dans l’année 2021

SELECT COUNT(DISTINCT ANIMATEUR.idAnimateur) + COUNT(DISTINCT PARTICIPE.idParticipant) AS NombrePersonne FROM ANIMATION
JOIN PARTICIPE ON PARTICIPE.idAnimation = Animation.idAnimation
JOIN ANIMATEUR ON ANIMATEUR.idAnimateur = ANIMATION.idAnimateur
WHERE dateAnimation BETWEEN '1/01/2021' AND '01/01/2022'


--------------------------------------------------------------------------------

Q9 : -- 9. Nom des personnes ayant participé aux animations « Forum » et « JPO ».

SELECT DISTINCT nom as Forum FROM PARTICIPANT
JOIN PARTICIPE ON PARTICIPE.idParticipant = PARTICIPANT.idParticipant
JOIN ANIMATION ON ANIMATION.idAnimation = PARTICIPE.idAnimation

WHERE ANIMATION.titre = 'Forum'

INTERSECT

SELECT DISTINCT nom  as JPO FROM PARTICIPANT
JOIN PARTICIPE ON PARTICIPE.idParticipant = PARTICIPANT.idParticipant
JOIN ANIMATION ON ANIMATION.idAnimation = PARTICIPE.idAnimation

WHERE ANIMATION.titre = 'JPO'

----------------------------------------------------------------------------------

Q10 : -- 10. Animateurs n’ayant jamais animé après 18 heures.

SELECT DISTINCT ANIMATEUR.nom FROM ANIMATEUR
JOIN ANIMATION ON ANIMATION.idAnimateur = ANIMATEUR.idAnimateur

WHERE NOT Heure > '18:00:00'

---------------------------------------------------------------------------------

Q11 : -- 11. Nom des animateurs ayant animé plus de 2 animations.

SELECT DISTINCT nom
FROM ANIMATEUR, ANIMATION
WHERE ANIMATEUR.idAnimateur = ANIMATION.idAnimateur
GROUP BY ANIMATEUR.nom
HAVING COUNT(ANIMATION.idAnimation) > 2;

--Aucun n'a fait plus de 2 animations, le maximum est 2

---------------------------------------------------------------------------------

Q12 : -- 12. Entreprises ayant envoyé plus de 3 personnes par animation.

SELECT nom FROM ENTREPRISE
WHERE identreprise IN (
    SELECT identreprise FROM PARTICIPANT
    GROUP BY identreprise
    HAVING COUNT(idParticipant) > 3
);

---------------------------------------------------------------------------------

Q13 : -- 13. Stand ayant eu le plus grand nombre de participants.




