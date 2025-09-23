-- QUESTION 1
CREATE TABLE EPREUVE (
    idEpreuve INT PRIMARY KEY,
    nomEpreuve VARCHAR(100) NOT NULL,
    dateEpreuve DATE NOT NULL,
    heureDepart TIME NOT NULL
);

CREATE TABLE ATHLETE (
    idAthlete INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    nationalite VARCHAR(50) NOT NULL
);

CREATE TABLE PARTICIPE (
    idAthlete INT,
    idEpreuve INT,
    classement INT,
    PRIMARY KEY (idAthlete, idEpreuve),
    FOREIGN KEY (idAthlete) REFERENCES ATHLETE (idAthlete),
    FOREIGN KEY (idEpreuve) REFERENCES EPREUVE (idEpreuve)
);

INSERT INTO
    ATHLETE
VALUES (1, 'Dupont', 'Lucas', 'FR'),
    (2, 'Martin', 'Claire', 'FR'),
    (3, 'Rossi', 'Marco', 'IT'),
    (4, 'Bianchi', 'Giulia', 'IT'),
    (5, 'Smith', 'John', 'US'),
    (6, 'Garcia', 'Maria', 'ES'),
    (7, 'Kumar', 'Raj', 'IN'),
    (8, 'Müller', 'Anna', 'DE');

INSERT INTO
    EPREUVE
VALUES (
        1,
        '100m',
        '2022-01-10',
        '12:30:00'
    ),
    (
        2,
        '200m',
        '2022-01-10',
        '15:00:00'
    ),
    (
        3,
        'Marathon',
        '2022-01-11',
        '14:00:00'
    ),
    (
        4,
        'Saut en longueur',
        '2022-02-05',
        '10:00:00'
    ),
    (
        5,
        'Lancer de javelot',
        '2022-02-06',
        '16:00:00'
    );

INSERT INTO
    PARTICIPE
VALUES (1, 1, 1), -- Dupont gagne
    (2, 1, 2),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 5);

INSERT INTO
    PARTICIPE
VALUES (1, 2, 3),
    (3, 2, 1), -- Rossi gagne
    (6, 2, 2),
    (7, 2, 4);

INSERT INTO
    PARTICIPE
VALUES (2, 3, 1), -- Claire gagne
    (4, 3, 2),
    (5, 3, 3),
    (8, 3, 4);

INSERT INTO
    PARTICIPE
VALUES (6, 4, 1), -- Maria gagne
    (7, 4, 2);

INSERT INTO PARTICIPE VALUES (3, 5, 2), (8, 5, 1);
-- Anna gagne

-- QUESTION 2
SELECT "ATHLETE".nom, "ATHLETE".prenom
FROM "ATHLETE"
WHERE
    nationalite IN ('FR', 'IT')
ORDER BY nom, prenom ASC

-- QUESTION 3
SELECT DISTINCT
    nom,
    prenom
FROM athlete
    JOIN participe ON athlete.idAthlete = participe.idAthlete
WHERE
    classement = 1

-- QUESTION 4
SELECT E.nomEpreuve, COUNT(*) AS nombre_participants
FROM Epreuve E
    JOIN Participe P ON E.idEpreuve = P.idEpreuve
GROUP BY
    E.nomEpreuve,
    E.idEpreuve
ORDER BY nombre_participants DESC;

-- QUESTION 5
SELECT nationalite, COUNT(*)
FROM
    athlete
    JOIN participe ON athlete.idAthlete = participe.idAthlete
    JOIN epreuve ON participe.idEpreuve = epreuve.idEpreuve
WHERE
    YEAR(dateEpreuve) = 2022
    AND classement <= 3
GROUP BY
    nationalite;

-- QUESTION 6
SELECT idAthlete, nom, prenom
FROM ATHLETE
EXCEPT
SELECT ATHLETE.idAthlete, nom, prenom
FROM
    ATHLETE
    JOIN PARTICIPE ON PARTICIPE.idAthlete = ATHLETE.idAthlete
    JOIN EPREUVE ON EPREUVE.idEpreuve = PARTICIPE.idEpreuve
WHERE
    nomEpreuve = '100m';

-- QUESTION 7 : Liste des athlètes ayant participé à au moins une épreuve le 10 janvier 2022 entre 12h et 18h et au moins une autre épreuve le 11 janvier 2022 entre 12h et 18h.
SELECT athlete.idAthlete, nom, prenom
FROM
    athlete
    JOIN participe ON athlete.idAthlete = participe.idAthlete
    JOIN epreuve ON participe.idEpreuve = epreuve.idEpreuve
WHERE
    dateEpreuve = '2022-01-10'
    AND heureDepart BETWEEN '12:00:00' AND '18:00:00'
INTERSECT
SELECT athlete.idAthlete, nom, prenom
FROM
    athlete
    JOIN participe ON athlete.idAthlete = participe.idAthlete
    JOIN epreuve ON participe.idEpreuve = epreuve.idEpreuve
WHERE
    dateEpreuve = '2022-01-11'
    AND heureDepart BETWEEN '12:00:00' AND '18:00:00';

-- QUESTION 8
SELECT "ATHLETE".nom, "ATHLETE".prenom
FROM
    "ATHLETE"
    JOIN "PARTICIPE" ON "PARTICIPE"."idAthlete" = "ATHLETE"."idAthlete"
    JOIN "EPREUVE" ON "EPREUVE"."idEpreuve" = "PARTICIPE"."idEpreuve"
WHERE
    YEAR("EPREUVE"."dateEpreuve") = 2022
GROUP BY
    "ATHLETE"."idAthlete",
    "ATHLETE".nom,
    "ATHLETE".prenom
HAVING
    COUNT("PARTICIPE"."idEpreuve") > 2;

-- QUESTION 9 Liste des derniers athlètes de chaque épreuve.
SELECT A.nom, A.prenom, E.nomEpreuve
FROM
    ATHLETE A
    JOIN PARTICIPE P ON A.idAthlete = P.idAthlete
    JOIN EPREUVE E ON P.idEpreuve = E.idEpreuve
WHERE P.classement = (
        SELECT MAX(classement)
        FROM PARTICIPE P2
        WHERE P2.idEpreuve = P.idEpreuve
    );