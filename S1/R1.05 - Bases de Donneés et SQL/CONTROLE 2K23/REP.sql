#####################################################################
####################### EXERCICE 1 : ################################
#####################################################################

Q1 : -- Définissez la notion de restriction d'une relation en algèbre relationnelle. Comment se traduit la restriction en langage SQL ?

--La restriction d'une relation en algèbre relationnelle, également appelée sélection, est une opération qui permet de 
--filtrer les lignes d'une table en fonction de certaines conditions. En d'autres termes, elle extrait les lignes qui satisfont une condition donnée.

-- En langage SQL, la restriction se traduit par l'utilisation de la clause WHERE dans une requête SELECT. 
-- La clause WHERE permet de spécifier les conditions que les lignes doivent remplir pour être incluses dans le résultat de la requête.


-- EXEMPLE :

-- Algèbre relationnelle : σ(condition)(Relation)
-- SQL : SELECT * FROM Relation WHERE condition;

-- Exemple concret
-- Supposons que nous avons une table `Employes` et nous voulons sélectionner les employés dont le salaire est supérieur à 50000.

SELECT * FROM Employes
WHERE salaire > 50000;

--Dans cet exemple, la restriction est appliquée pour sélectionner uniquement les lignes de la table Employes où la colonne salaire est supérieure à 50000

#####################################################################
#####################################################################
#####################################################################

Q2 : -- Définissez la notion de différence de deux relations en algèbre relationnelle. Comment se traduit la différence en langage SQL ?

-- En algèbre relationnelle, la différence de deux relations ( R ) et ( S ) (notée ( R - S )) est une 
-- opération qui retourne les tuples présents dans la relation ( R ) mais pas dans la relation ( S ).

-- En SQL, cette opération peut être réalisée en utilisant la clause EXCEPT. Voici un exemple :

SELECT * FROM R
EXCEPT
SELECT * FROM S;

--Cette requête retourne tous les enregistrements de la table R qui ne sont pas présents dans la table S.

-- Il est important de noter que certaines bases de données utilisent la clause MINUS 
-- au lieu de EXCEPT pour réaliser cette opération. Assurez-vous de vérifier la documentation 
-- de votre SGBD pour connaître la syntaxe correcte.


#####################################################################
#####################################################################
#####################################################################

Q3 : -- Définissez l’utilité des contraintes CHECK et DEFAULT ?

-- Les contraintes CHECK et DEFAULT sont des mécanismes utilisés dans les bases de données relationnelles pour assurer l'intégrité des données.

--Contrainte CHECK
--La contrainte CHECK est utilisée pour limiter les valeurs qu'une colonne peut accepter. Elle impose une condition qui doit être vraie pour chaque ligne de la table. Par exemple, si vous avez une colonne age et que vous voulez vous assurer que l'âge est toujours supérieur ou égal à 18, vous pouvez utiliser une contrainte CHECK.

--Exemple :
CREATE TABLE Person (
    ID int,
    Name varchar(255),
    Age int,
    CHECK (Age >= 18)
);


--Contrainte DEFAULT
--La contrainte DEFAULT est utilisée pour fournir une valeur par défaut pour une colonne lorsque aucune valeur n'est spécifiée lors de l'insertion d'une nouvelle ligne. Cela permet de s'assurer que la colonne ne reste pas vide et a une valeur significative par défaut.

--Exemple :
CREATE TABLE Person (
    ID int,
    Name varchar(255),
    Country varchar(255) DEFAULT 'France'
);

-- Dans cet exemple, si aucune valeur n'est fournie pour la colonne Country lors de l'insertion d'une nouvelle ligne, la valeur par défaut sera 'France'.

-- Ces contraintes aident à maintenir l'intégrité et la cohérence des données dans la base de données.

#####################################################################
#####################################################################
#####################################################################

-- Soit la table et les données définies par le script suivant :
CREATE TABLE STOCK (OBJET VARCHAR(6) NOT NULL, PRIX DECIMAL(3,2) NOT NULL)
INSERT INTO STOCK VALUES ('Vis', 0.65), ('Clou', 0.35), ('Pointe', 0.23)

Q4 : 
-- 4. Pour chacune des requêtes suivantes donnez le résultat obtenu sous la forme d’un tableau résultat :
-- a) SELECT COUNT(PRIX) AS VAL FROM STOCK
        VAL
        3

-- b) SELECT SUM(PRIX) AS VAL FROM STOCK WHERE PRIX>0.3
        VAL
        1.00

-- c) SELECT OBJET FROM STOCK UNION SELECT 'Ecrou' ORDER BY OBJET ASC
        OBJET
        Clou
        Ecrou
        Pointe
        Vis

#####################################################################

Q5 : 
-- 5. Que se passe-t-il lorsque que l'on exécute les commandes suivantes :
-- a) INSERT INTO STOCK VALUES ('Marteau', 9.4)
    -- Cela rentrera Marteau avec un prix à 9.4€

-- b) INSERT INTO STOCK VALUES ('Scie', 10.5)
    -- Cela rentrera Scie avec un prix à 10.5€

-- c) INSERT INTO STOCK (OBJET) VALUES ('Lime')
    -- Génère une erreur car la colonne PRIX ne peut pas être NULL

#####################################################################

Q6 : 
-- 6. Écrivez les commandes SQL permettant de :
-- a) Ajouter une clé primaire sur la colonne « OBJET »
    ALTER TABLE STOCK ADD PRIMARY KEY (OBJET);

-- b) Augmenter le prix de la « Vis » de 10%
    UPDATE STOCK SET PRIX = PRIX * 1.1 WHERE OBJET = 'Vis';


-- c) Effacer les tuples de la table « STOCK »
    DELETE FROM STOCK;

-- d) Supprimer la table « STOCK » de la base
    DROP TABLE STOCK;



#####################################################################
####################### EXERCICE 2 : ################################
#####################################################################

--Cette base de données est définie par le script suivant :

CREATE TABLE VILLE (
idVille INT PRIMARY KEY,
ville VARCHAR(50) NOT NULL
)

CREATE TABLE ENTREPRISE (
idEntreprise INT PRIMARY KEY,
entreprise VARCHAR(50) NOT NULL,
idVille INT FOREIGN KEY REFERENCES VILLE(idVille) NOT NULL
)

CREATE TABLE POSTE (
idPoste INT PRIMARY KEY,
poste VARCHAR(50) NOT NULL
)

CREATE TABLE EMPLOYE (
matricule INT UNIQUE,
nom VARCHAR(50) NOT NULL,
prenom VARCHAR(50) NOT NULL,
idVille INT FOREIGN KEY REFERENCES VILLE(idVille) NOT NULL,
idEntreprise INT FOREIGN KEY REFERENCES ENTREPRISE(idEntreprise) NOT NULL,
idPoste INT FOREIGN KEY REFERENCES POSTE(idPoste) NOT NULL,
dateEmbauche DATE NOT NULL,
salaire DECIMAL(10,2) NOT NULL
)


-- Réalisez les requêtes SQL suivantes :

-- 1. Affichez les nom et prénom des employés habitant à Limoges, embauchés en septembre 2023, et 
-- gagnant plus de 30000 euros. Triez le résultat par salaire croissant.    
    SELECT nom, prenom FROM EMPLOYE
    WHERE idVille = (SELECT idVille FROM VILLE WHERE ville = 'Limoges')
    AND dateEmbauche >= '2023-09-01' AND dateEmbauche <= '2023-09-30'
    AND salaire > 30000
    ORDER BY salaire ASC;

-- 2. Combien d'employés habitant à Paris occupent le poste d'ingénieur (attribut poste).
    SELECT COUNT(*) FROM EMPLOYE
    WHERE idVille = (SELECT idVille FROM VILLE WHERE ville = 'Paris')
    AND idPoste = (SELECT idPoste FROM POSTE WHERE poste = 'ingénieur');


-- 3. Affichez le salaire moyen par poste et triez le résultat par moyenne décroissante.
    SELECT poste, AVG(salaire) AS salaire_moyen
    FROM EMPLOYE
    JOIN POSTE ON EMPLOYE.idPoste = POSTE.idPoste
    GROUP BY poste
    ORDER BY salaire_moyen DESC;

-- 4. Affichez le nom des entreprises (attribut entreprise) qui n'ont aucun employé dans la base.
    SELECT entreprise FROM ENTREPRISE
    WHERE idEntreprise NOT IN (SELECT idEntreprise FROM EMPLOYE);

-- 5. Affichez les nom et prénom des employés habitant dans la même ville que leur entreprise.
    SELECT nom, prenom
    FROM EMPLOYE
    JOIN ENTREPRISE ON EMPLOYE.idEntreprise = ENTREPRISE.idEntreprise
    WHERE EMPLOYE.idVille = ENTREPRISE.idVille;

-- 6. Affichez le nom des entreprises ayant au moins deux employés dont le salaire dépasse 60000 euros.
    SELECT entreprise
    FROM ENTREPRISE
    JOIN EMPLOYE ON ENTREPRISE.idEntreprise = EMPLOYE.idEntreprise
    WHERE salaire > 60000
    GROUP BY entreprise
    HAVING COUNT(*) >= 2;
