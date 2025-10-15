CREATE TABLE ETUDIANT
(
	idEtudiant INT PRIMARY KEY,
	nom VARCHAR(30) NOT NULL,
	prenom VARCHAR(30) NOT NULL
)

CREATE TABLE PROJET
(
	idProjet INT PRIMARY KEY,
	titre VARCHAR(30) NOT NULL,
	description VARCHAR(30) NULL
)

CREATE TABLE MATIERE
(
	idMatiere INT PRIMARY KEY,
	intitule VARCHAR(30) NOT NULL,
	coefficient NUMERIC(2,1) NOT NULL
)

CREATE TABLE GROUPE
(
	idEtudiant INT FOREIGN KEY REFERENCES ETUDIANT(idEtudiant) NOT NULL,
	idProjet INT FOREIGN KEY REFERENCES PROJET(idProjet) NOT NULL,
	PRIMARY KEY (idEtudiant, idProjet)
)

CREATE TABLE NOTEPROJET
(
	idProjet INT FOREIGN KEY REFERENCES PROJET (idProjet) NOT NULL,
	noteProjet NUMERIC(4,2) NOT NULL,
	semestre INT NOT NULL,
	PRIMARY KEY (idProjet)
)

CREATE TABLE NOTE
(
	idEtudiant INT FOREIGN KEY REFERENCES ETUDIANT(idEtudiant) NOT NULL,
	idMatiere INT FOREIGN KEY REFERENCES MATIERE(idMatiere) NOT NULL,
	note NUMERIC(4,2) NOT NULL,
	semestre INT NOT NULL
)

insert into ETUDIANT
values
	(1, 'Dupont', 'Joe')
insert into ETUDIANT
values
	(2, 'Maro', 'Mike')
insert into ETUDIANT
values
	(3, 'Matin', 'Martine')
insert into ETUDIANT
values
	(4, 'Toulouse', 'Michel')
insert into ETUDIANT
values
	(5, 'Olive', 'Olivier')
insert into ETUDIANT
values
	(6, 'Rocky', 'John')

insert into PROJET
values
	(10, 'Projet Web', 'super projet web')
insert into PROJET
values
	(20, 'Projet PPP', 'super projet PPP')
insert into PROJET
values
	(30, 'Projet SQL', 'super projet SQL')
insert into PROJET
values
	(40, 'Projet ALGO', 'super projet ALGO')
insert into PROJET
values
	(50, 'Projet Forum', 'super projet Forum')

insert into MATIERE
values
	(100, 'MATH', 5.5)
insert into MATIERE
values
	(200, 'INFO', 7)
insert into MATIERE
values
	(300, 'ANGLAIS', 3)

insert into GROUPE
values
	(1, 10)
insert into GROUPE
values
	(2, 10)
insert into GROUPE
values
	(3, 20)
insert into GROUPE
values
	(4, 20)
insert into GROUPE
values
	(5, 30)
insert into GROUPE
values
	(5, 40)
insert into GROUPE
values
	(1, 40)

insert into NOTEPROJET
values
	(10, 12, 1)
insert into NOTEPROJET
values
	(20, 14, 1)
insert into NOTEPROJET
values
	(30, 16, 2)
insert into NOTEPROJET
values
	(40, 18, 3)

insert into NOTE
values
	(1, 100, 11, 1)
insert into NOTE
values
	(1, 200, 9, 1)
insert into NOTE
values
	(1, 300, 3, 1)
insert into NOTE
values
	(1, 100, 10, 2)
insert into NOTE
values
	(1, 200, 8, 2)
insert into NOTE
values
	(1, 300, 7, 2)
insert into NOTE
values
	(1, 100, 4, 3)
insert into NOTE
values
	(1, 200, 5, 3)
insert into NOTE
values
	(1, 300, 18, 3)

insert into NOTE
values
	(2, 100, 18, 1)
insert into NOTE
values
	(2, 200, 19, 1)
insert into NOTE
values
	(2, 300, 15, 1)
insert into NOTE
values
	(2, 100, 11, 2)
insert into NOTE
values
	(2, 200, 8, 2)
insert into NOTE
values
	(2, 300, 5, 2)
insert into NOTE
values
	(2, 100, 17, 3)
insert into NOTE
values
	(2, 200, 12, 3)
insert into NOTE
values
	(2, 300, 4, 3)

-- 1. Quels sont les 5 meilleurs étudiants de Math au deuxième semestre en considérant qu’il n’y a pas d’ex-aequo ?
SELECT TOP 5
	E.idEtudiant, E.nom, E.prenom, N.note
FROM ETUDIANT E
	JOIN NOTE N ON E.idEtudiant = N.idEtudiant
WHERE N.idMatiere = 100 AND N.semestre = 2
ORDER BY N.note DESC

-- 2. Quels sont les étudiants du projet ayant obtenu la meilleure note au cours du premier semestre ?
SELECT E.idEtudiant, E.nom, E.prenom, NP.noteProjet
FROM ETUDIANT E
	JOIN GROUPE G ON E.idEtudiant = G.idEtudiant
	JOIN NOTEPROJET NP ON G.idProjet = NP.idProjet
WHERE NP.semestre = 1 AND NP.noteProjet = (
	SELECT MAX(noteProjet)
	FROM NOTEPROJET
	WHERE semestre = 1
)

--3. Créez une vue permettant d’afficher, par semestre, la moyenne de chaque matière ainsi que la moyenne des projets
GO
CREATE VIEW MoyennesParSemestre
AS
	SELECT semestre,
		AVG(CASE WHEN idMatiere IS NOT NULL THEN note END) AS MoyenneMatiere,
		AVG(CASE WHEN idMatiere IS NULL THEN noteProjet END) AS MoyenneProjet
	FROM (
								SELECT semestre, note, NULL AS noteProjet, idMatiere
			FROM NOTE
		UNION ALL
			SELECT semestre, NULL AS note, noteProjet, NULL AS idMatiere
			FROM NOTEPROJET
) AS AllNotes
	GROUP BY semestre;

DROP VIEW MoyennesParSemestre
GO

-- 4. Créez une procédure stockée affichant la moyenne par matière de chaque étudiant ainsi que la
--    moyenne des projets. La procédure prendra le numéro du semestre en paramètre. Si aucune
--    note n’est disponible pour le semestre demandé, vous afficherez un message dans la console.
CREATE PROCEDURE test
	@numSemestre INT
AS
BEGIN
	-- Vérifie si des notes existent pour le semestre donné
	IF NOT EXISTS (
        						SELECT note
		FROM NOTE
		WHERE semestre = @numSemestre
	UNION
		SELECT noteProjet
		FROM NOTEPROJET
		WHERE semestre = @numSemestre
    )
    BEGIN
		PRINT('Mauvais semestre donné : semestre = ' + CONVERT(VARCHAR, @numSemestre));
	END
    ELSE
    BEGIN
		-- Moyennes par matière
					SELECT
				M.intitule,
				E.nom,
				E.prenom,
				AVG(N.note) AS Moyenne
			FROM ETUDIANT E
				JOIN NOTE N ON N.idEtudiant = E.idEtudiant
				JOIN MATIERE M ON N.idMatiere = M.idMatiere
			WHERE N.semestre = @numSemestre
			GROUP BY M.intitule, E.nom, E.prenom

		UNION

			-- Moyennes des projets
			SELECT
				'Projet' AS intitule,
				E.nom,
				E.prenom,
				AVG(NP.noteProjet) AS Moyenne
			FROM ETUDIANT E
				JOIN GROUPE G ON G.idEtudiant = E.idEtudiant
				JOIN NOTEPROJET NP ON NP.idProjet = G.idProjet
			WHERE NP.semestre = @numSemestre
			GROUP BY E.nom, E.prenom

		ORDER BY intitule, nom, prenom;
	END
END;

DROP PROCEDURE test;

-- 5. Créez une vue permettant d’afficher la moyenne générale (matières et projets inclus) de chaque étudiant par semestre.
GO
CREATE VIEW MoyenneGeneraleParEtudiantParSemestre
AS
	SELECT
		E.idEtudiant,
		E.nom,
		E.prenom,
		N.semestre,
		AVG(COALESCE(N.note, NP.noteProjet)) AS MoyenneGenerale
	FROM ETUDIANT E
		LEFT JOIN NOTE N ON E.idEtudiant = N.idEtudiant
		LEFT JOIN GROUPE G ON E.idEtudiant = G.idEtudiant
		LEFT JOIN NOTEPROJET NP ON G.idProjet = NP.idProjet AND N.semestre = NP.semestre
	GROUP BY E.idEtudiant, E.nom, E.prenom, N.semestre
	ORDER BY E.idEtudiant, N.semestre;
DROP VIEW MoyenneGeneraleParEtudiantParSemestre
GO

-- 6. Créez une procédure stockée affichant la moyenne générale (matières et projets inclus) de chaque étudiant par semestre.	