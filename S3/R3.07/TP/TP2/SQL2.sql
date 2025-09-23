/* TABLES */
CREATE TABLE JOUEUR
(
    idJoueur INT PRIMARY KEY,
    nom VARCHAR(30) NOT NULL,
    age SMALLINT NULL,
    nationalite VARCHAR(30) NULL
)

CREATE TABLE JEUX
(
    idJeux INT PRIMARY KEY,
    titre VARCHAR(30) NOT NULL,
    version VARCHAR(30) NULL
)

CREATE TABLE PARTIE
(
    idJoueur INT FOREIGN KEY REFERENCES JOUEUR (idJoueur) NOT NULL,
    idJeux INT FOREIGN KEY REFERENCES JEUX (idJeux) NOT NULL,
    datePartie DATE NULL,
    score INT NULL
)

CREATE TABLE TOPSCORE
(
    idJoueur INT FOREIGN KEY REFERENCES JOUEUR (idJoueur) NOT NULL,
    idJeux INT FOREIGN KEY REFERENCES JEUX (idJeux) NOT NULL,
    scoreMAX INT NULL,
    PRIMARY KEY (idJoueur, idJeux)
)

/* DATAS */
INSERT INTO
    JOUEUR
VALUES
    (1, 'Alice', 20, 'Française'),
    (2, 'Bob', 25, 'Belge'),
    (3, 'Charlie', 30, 'Française'),
    (4, 'David', 22, 'Suisse');

INSERT INTO
    JEUX
VALUES
    (101, 'Mario Kart', 'v1'),
    (102, 'Mario Kart', 'v2'),
    (201, 'Zelda', 'v1');

INSERT INTO
    PARTIE
VALUES
    (1, 101, '2025-09-10', 150),
    (1, 102, '2025-09-12', 180),
    (1, 201, '2025-09-13', 90),
    (2, 101, '2025-09-11', 200),
    (2, 102, '2025-09-12', 190),
    (2, 201, '2025-09-14', 80),
    (3, 201, '2025-09-15', 95);

INSERT INTO "PARTIE"
VALUES
    (1, 101, '2025-09-12', 550)

INSERT INTO
    TOPSCORE
VALUES
    (1, 101, 180),
    (1, 201, 90),
    (2, 101, 200),
    (2, 201, 80),
    (3, 201, 95);

/* QST 2 */
-- Combien de joueurs n'ont jamais joué (écrivez la requête de 3 façons différentes) ?
SELECT COUNT(*) AS nb_joueurs_sans_partie
FROM JOUEUR j
    LEFT JOIN PARTIE p ON j.idJoueur = p.idJoueur
WHERE
    p.idJoueur IS NULL;
-- 2ème façon
SELECT COUNT(*) AS nb_joueurs_sans_partie
FROM JOUEUR
WHERE
    idJoueur NOT IN (
        SELECT DISTINCT
    idJoueur
FROM PARTIE
    );
-- 3ème façon
SELECT COUNT(*) AS nb_joueurs_sans_partie
FROM JOUEUR
WHERE
    NOT EXISTS (
        SELECT 1
FROM PARTIE
WHERE
            PARTIE.idJoueur = JOUEUR.idJoueur
    );

/* QST 3 */
-- Quels joueurs ont joué au moins à 2 jeux différents ?
SELECT j.nom, COUNT(*) AS "nombre_partie_joue"
FROM JOUEUR j
    JOIN PARTIE p ON p.idJoueur = j."idJoueur"
GROUP BY
    j.nom
HAVING
    COUNT(*) > 2

/* QST 4 */
-- Listez les 3 meilleurs joueurs du jeu TETRIS.
SELECT TOP 3
    j.nom, je.titre, je.version, t.scoreMAX
FROM
    JOUEUR j
    JOIN TOPSCORE t ON t.idJoueur = j.idJoueur
    JOIN JEUX je ON je.idJeux = t.idJeux
WHERE
    je.titre = 'Tetris'
ORDER BY t.scoreMAX DESC

/* QST 5 */
-- Quel est le jeu le plus joué (gérer le cas des doublons) ?
WITH
    parties_par_jeu
    AS
    (
        SELECT p.idJeux, COUNT(*) AS parties_joues
        FROM PARTIE p
        GROUP BY
            p.idJeux
    ),
    parties_par_titre
    AS
    (
        SELECT j.titre, SUM(ppj.parties_joues) AS total_parties
        FROM parties_par_jeu ppj
            JOIN JEUX j ON j.idJeux = ppj.idJeux
        GROUP BY
            j.titre
    ),
    max_parties
    AS
    (
        SELECT MAX(total_parties) AS max_total
        FROM parties_par_titre
    )
SELECT ppt.titre, ppt.total_parties
FROM
    parties_par_titre ppt
    JOIN max_parties mp ON ppt.total_parties = mp.max_total
ORDER BY ppt.total_parties DESC;

/* QST 6 */
-- Écrivez un script SQL permettant de remplir l’ensemble de la table TOPSCORE en considérant que cette-dernière est vide. */
INSERT INTO
    TOPSCORE
SELECT T2.j, PARTIE.idJeux, T2.s
FROM JEUX, PARTIE, (
        SELECT T1.t AS "t", T1.j AS "j", T1.s AS "s", MIN(PARTIE.datePartie) AS "d"
    FROM JEUX, PARTIE, (
                SELECT titre AS "t", PARTIE.idJoueur AS "j", MAX(score) AS "s"
        FROM JOUEUR, JEUX, PARTIE
        WHERE
                    JOUEUR.idJoueur = PARTIE.idJoueur
            AND JEUX.idJeux = PARTIE.idJeux
        GROUP BY
                    titre, PARTIE.idJoueur
            ) T1
    WHERE
            JEUX.idJeux = PARTIE.idJeux
        AND T1.j = PARTIE.idJoueur
        AND T1.s = PARTIE.score
    GROUP BY
            "t", "j", "s"
    ) T2
WHERE
    JEUX.idJeux = PARTIE.idJeux
    AND T2.j = PARTIE.idJoueur
    AND T2.s = PARTIE.score
    AND T2.d = PARTIE.datePartie
    AND T2.t = JEUX.titre

/* QST 7 */
-- Donnez le score moyen par joueur et par jeu de l’ensemble des joueurs présents dans la base (les joueurs n’ayant jamais joué devront apparaître dans la liste avec la valeur ‘N/A’). */
SELECT JOUEUR.nom, COALESCE(JEUX.titre, 'N/A') AS titre, COALESCE(
        CONVERT(
            VARCHAR(50), AVG(PARTIE.score)
        ), 'N/A'
    ) AS score
FROM JOUEUR
    LEFT OUTER JOIN PARTIE ON JOUEUR.idJoueur = PARTIE.idJoueur
    LEFT OUTER JOIN JEUX ON PARTIE.idJeux = JEUX.idJeux
GROUP BY
    JOUEUR.nom,
    JEUX.titre;

/* QST 8 */
-- A l’aide d’un curseur, écrivez un script permettant de remplir l’ensemble de la table TOPSCORE en considérant que cette-dernière est vide.
DECLARE @idJoueur  INT,
        @idJeux    INT,
        @score     INT,
        @titre     VARCHAR(30),
        @scoreMax  INT,
        @idJeuxMax INT;

DECLARE topScoreCursor CURSOR FOR
    SELECT p.idJoueur, p.idJeux, p.score, j.titre
FROM PARTIE p
    JOIN JEUX j ON p.idJeux = j.idJeux
ORDER BY p.datePartie;

OPEN topScoreCursor;

FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @score, @titre;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- réinitialiser les variables
    SET @scoreMax = NULL;
    SET @idJeuxMax = NULL;

    -- chercher le score max existant pour ce joueur et ce jeu
    SELECT @scoreMax = t.scoreMax,
        @idJeuxMax = t.idJeux
    FROM TOPSCORE t
        JOIN JEUX j ON t.idJeux = j.idJeux
    WHERE j.titre = @titre
        AND t.idJoueur = @idJoueur;

    -- si pas encore de score enregistré
    IF @scoreMax IS NULL
    BEGIN
        INSERT INTO TOPSCORE
            (idJoueur, idJeux, scoreMax)
        VALUES
            (@idJoueur, @idJeux, @score);
    END
    ELSE
    BEGIN
        -- si le nouveau score est meilleur
        IF (@score > @scoreMax)
        BEGIN
            DELETE FROM TOPSCORE
            WHERE idJoueur = @idJoueur
                AND idJeux   = @idJeuxMax;

            INSERT INTO TOPSCORE
                (idJoueur, idJeux, scoreMax)
            VALUES
                (@idJoueur, @idJeux, @score);
        END
    END;

    FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @score, @titre;
END;

SELECT *
FROM "TOPSCORE";

CLOSE topScoreCursor;
DEALLOCATE topScoreCursor;

/* QST 9 */
-- Ecrivez le déclencheur de mise à jour de la table TOPSCORE se déclenchant à chaque nouvelle partie enregistrée dans la base.
GO
CREATE TRIGGER updateTopScore
ON PARTIE
AFTER INSERT
AS
BEGIN
    DECLARE @idJoueur  INT,
            @idJeux    INT,
            @score     INT,
            @titre     VARCHAR(30),
            @scoreMax  INT,
            @idJeuxMax INT;

    DECLARE topScoreCursor CURSOR FOR
        SELECT p.idJoueur, p.idJeux, j.titre, p.score
    FROM PARTIE p
        JOIN JEUX j ON p.idJeux = j.idJeux
    ORDER BY p.datePartie;

    OPEN topScoreCursor;

    FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @titre, @score;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Vérifie si le joueur n’a pas encore de score pour ce jeu
        IF NOT EXISTS (
            SELECT 1
        FROM TOPSCORE t
            JOIN JEUX j ON t.idJeux = j.idJeux
        WHERE j.titre = @titre
            AND t.idJoueur = @idJoueur
        )
        BEGIN
            INSERT INTO TOPSCORE
                (idJoueur, idJeux, scoreMax)
            VALUES
                (@idJoueur, @idJeux, @score);
        END
        ELSE
        BEGIN
            SET @scoreMax = (
                SELECT t.scoreMax
            FROM TOPSCORE t
                JOIN JEUX j ON t.idJeux = j.idJeux
            WHERE j.titre = @titre
                AND t.idJoueur = @idJoueur
            );

            IF (@score > @scoreMax)
            BEGIN
                SET @idJeuxMax = (
                    SELECT t.idJeux
                FROM TOPSCORE t
                    JOIN JEUX j ON t.idJeux = j.idJeux
                WHERE j.titre = @titre
                    AND t.idJoueur = @idJoueur
                );

                DELETE FROM TOPSCORE
                WHERE idJoueur = @idJoueur
                    AND idJeux   = @idJeuxMax;

                INSERT INTO TOPSCORE
                    (idJoueur, idJeux, scoreMax)
                VALUES
                    (@idJoueur, @idJeux, @score);
            END
        END;

        FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @titre, @score;
    END;

    CLOSE topScoreCursor;
    DEALLOCATE topScoreCursor;
END;

/* QST 10 */
-- A l’aide d’un curseur, vérifiez les données de la table TOPSCORE. Si une ligne n’est pas correcte (mauvais scoreMax ou aucune partie jouée pour le joueur) vous devez l’afficher dans la console.
DECLARE @idJoueur  INT,
        @idJeux    INT,
        @score     INT,
        @titre     VARCHAR(30),
        @scoreMax  INT,
        @idJeuxMax INT;

DECLARE topScoreCursor CURSOR FOR
    SELECT t.idJoueur, t.idJeux, t.scoreMax, j.titre
FROM TOPSCORE t
    JOIN JEUX j ON t.idJeux = j.idJeux
ORDER BY t.idJoueur, t.idJeux;

OPEN topScoreCursor;

FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @score, @titre;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Vérification du joueur ' + CAST(@idJoueur AS VARCHAR) + ' pour le jeu ' + CAST(@idJeux AS VARCHAR) + ' (' + @titre + ') avec un score de ' + CAST(@score AS VARCHAR);
    -- vérfier que la partie existe
    IF NOT EXISTS (
        SELECT 1
    FROM PARTIE pa
    WHERE pa.idJoueur = @idJoueur
        AND pa.idJeux   = @idJeux
    ) BEGIN
        PRINT 'Erreur: Le joueur ' + CAST(@idJoueur AS VARCHAR) + ' n''a jamais joué au jeu ' + CAST(@idJeux AS VARCHAR);
    END;

    -- chercher le score max existant pour ce joueur et ce jeu
    SELECT @scoreMax = t.scoreMax,
        @idJeuxMax = t.idJeux
    FROM TOPSCORE t
    WHERE t.idJoueur = @idJoueur
        AND t.idJeux   = @idJeux;
    -- vérifier que le score max est correct
    IF @scoreMax IS NOT NULL AND @score > @scoreMax
    BEGIN
        PRINT 'Erreur: Le joueur ' + CAST(@idJoueur AS VARCHAR) + ' a un score de ' + CAST(@score AS VARCHAR) + ' pour le jeu ' + CAST(@idJeux AS VARCHAR) + ', mais le score max est ' + CAST(@scoreMax AS VARCHAR);
    END;

    FETCH NEXT FROM topScoreCursor INTO @idJoueur, @idJeux, @score, @titre;
END;

CLOSE topScoreCursor;
DEALLOCATE topScoreCursor;

GO
-- 11. Ecrivez le déclencheur permettant de conserver la cohérence des données de la table TOPSCORE en cas de suppression ou modification d’un score de la table PARTIE.
CREATE TRIGGER maintainTopScore
ON PARTIE
AFTER DELETE, UPDATE
AS
BEGIN
    -- Supprimer les topscores pour lesquels il n’y a plus de partie
    DELETE FROM TOPSCORE
    WHERE EXISTS (
        SELECT 1
        FROM DELETED d
        WHERE d.idJoueur = TOPSCORE.idJoueur
          AND d.idJeux   = TOPSCORE.idJeux
    )
    AND NOT EXISTS (
        SELECT 1
        FROM PARTIE p
        WHERE p.idJoueur = TOPSCORE.idJoueur
          AND p.idJeux   = TOPSCORE.idJeux
    );

    -- Mettre à jour les topscores existants
    UPDATE TOPSCORE
    SET scoreMax = (
        SELECT MAX(p.score)
        FROM PARTIE p
        WHERE p.idJoueur = TOPSCORE.idJoueur
          AND p.idJeux   = TOPSCORE.idJeux
    )
    WHERE EXISTS (
        SELECT 1
        FROM DELETED d
        WHERE d.idJoueur = TOPSCORE.idJoueur
          AND d.idJeux   = TOPSCORE.idJeux
    );
END;
GO

-- 12.  Proposez un nouveau modèle relationnel permettant de simplifier la gestion des jeux et de
-- leurs versions. Ecrivez les scripts de mise à jour de votre base ainsi que de migration des
-- données. Les données existantes dans la base d’origine seront réintroduites dans la
-- nouvelle sans être ressaisies à la main.

