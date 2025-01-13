create database CHECKPOINT_Relational_database_management;

use CHECKPOINT_Relational_database_management;

-- Création des tables

CREATE TABLE vins (
    id_vin INT PRIMARY KEY,
    categorie VARCHAR(50),
    annee INT,
    degre FLOAT
);

CREATE TABLE producteurs (
    id_producteur INT PRIMARY KEY,
    prenom VARCHAR(50),
    nom VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE recolte (
    id_recolte INT PRIMARY KEY,
    id_vin INT,
    id_producteur INT,
    quantite INT,
    FOREIGN KEY (id_vin) REFERENCES vins(id_vin),
    FOREIGN KEY (id_producteur) REFERENCES producteurs(id_producteur)
);

-- Insertion des données dans la table vins

INSERT INTO vins (id_vin, categorie, annee, degre) VALUES
(1, 'Rouge', 2019, 13.5), (2, 'Blanc', 2020, 12.0), (3, 'Rose', 2018, 11.5),
(4, 'Red', 2021, 14.0), (5, 'Sparkling', 2017, 10.5), (6, 'Blanc', 2019, 12.5),
(7, 'Rouge', 2022, 13.0), (8, 'Rose', 2020, 11.0), (9, 'Rouge', 2018, 12.0),
(10, 'Sparkling', 2019, 10.0), (11, 'Blanc', 2021, 11.5), (12, 'Rouge', 2022, 15.0);

-- Insertion des données dans la table producteurs

INSERT INTO producteurs (id_producteur, prenom, nom, region) VALUES
(1, 'John', 'Smith', 'Sousse'), (2, 'Emma', 'Johnson', 'Tunis'), (3, 'Michael', 'Williams', 'Sfax'),
(4, 'Emily', 'Brown', 'Sousse'), (5, 'James', 'Jones', 'Sousse'), (6, 'Sarah', 'Davis', 'Tunis'),
(7, 'David', 'Miller', 'Sfax'), (8, 'Olivia', 'Wilson', 'Monastir'), (9, 'Daniel', 'Moore', 'Sousse'),
(10, 'Sophia', 'Taylor', 'Tunis'), (11, 'Matthieu', 'Anderson', 'Sfax'), (12, 'Amélia', 'Thomas', 'Sousse');

-- Insertion des données dans la table recolte

INSERT INTO recolte (id_recolte, id_vin, id_producteur, quantite) VALUES
(1, 1, 1, 500), (2, 2, 2, 300), (3, 3, 3, 200), (4, 4, 4, 450),
(5, 5, 5, 150), (6, 6, 6, 350), (7, 7, 7, 400), (8, 8, 8, 250),
(9, 9, 9, 300), (10, 10, 10, 100), (11, 1, 1, 150), (12, 12, 12, 600);

-- 4 Récupérer une liste de tous les producteurs

SELECT*
FROM producteurs;

-- 5 Récupérer une liste triée de producteurs par nom 

SELECT * 
FROM producteurs ORDER BY nom;


-- 6 Récupérer une liste de producteurs de Sousse 

SELECT * 
FROM producteurs WHERE region = 'Sousse';


-- 7 Calculez la quantité totale de vin produite avec le numéro de vin 12

SELECT SUM(quantite) AS total_quantite 
FROM recolte 
WHERE id_vin = 12;


-- 8 Calculez la quantité de vin produite pour chaque catégorie

SELECT v.categorie, SUM(r.quantite) AS total_quantite
FROM recolte r
JOIN vins v ON r.id_vin = v.id_vin
GROUP BY v.categorie;


-- 9 Retrouvez les producteurs de Sousse ayant récolté au moins un vin en quantité supérieure à 300 litres 

SELECT DISTINCT p.prenom, p.nom
FROM recolte r
JOIN producteurs p ON r.id_producteur = p.id_producteur
WHERE p.region = 'Sousse' AND r.quantite > 300
ORDER BY p.nom;


-- 10 Citez les numéros de vins avec un degré supérieur à 12, produits par le producteur numéro 24

SELECT r.id_vin
FROM recolte r
JOIN vins v ON r.id_vin = v.id_vin
WHERE v.degre > 12 AND r.id_producteur = 24;


-- 11 Trouvez le producteur qui a produit la plus grande quantité de vin

SELECT TOP 1 p.prenom, p.nom, SUM(r.quantite) AS total_quantite
FROM recolte r
JOIN producteurs p ON r.id_producteur = p.id_producteur
GROUP BY p.prenom, p.nom
ORDER BY total_quantite DESC;



-- 12 Trouvez le degré moyen de vin produit

SELECT AVG(degre) AS degre_moyen FROM vins;


-- 13 Trouvez le vin le plus ancien de la base de données

SELECT TOP 1 * FROM vins ORDER BY annee ASC;


-- 14 Récupérez une liste de producteurs ainsi que la quantité totale de vin qu'ils ont produite

SELECT p.prenom, p.nom, SUM(r.quantite) AS total_quantite
FROM recolte r
JOIN producteurs p ON r.id_producteur = p.id_producteur
GROUP BY p.prenom, p.nom;


-- 15 Récupérez une liste de vins ainsi que les coordonnées de leurs producteurs

SELECT v.id_vin, v.categorie, v.annee, v.degre, p.prenom, p.nom, p.region
FROM recolte r
JOIN vins v ON r.id_vin = v.id_vin
JOIN producteurs p ON r.id_producteur = p.id_producteur;





