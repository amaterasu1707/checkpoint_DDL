create database checkpoint_DATA_QUERY_LANGUAGE;

use checkpoint_DATA_QUERY_LANGUAGE;

create database CHECKPOINT_DML;

USE CHECKPOINT_DML;

create table clients (
	customer_id int primary key,
	nom_client varchar (30) not null,
	customer_tel varchar (50) not null,
);

create table produits (
	product_id int primary key,
	nom_produit varchar (50) not null,
	categorie varchar (30) not null,
	prix decimal (10,2) not null,
);

create table commande (
	order_id int primary key,
	customer_id int not null,
	product_id int not null,
	quantit� int not null,
	order_date date not null,
	constraint fk_customer_id foreign key (customer_id) references clients (customer_id),
	constraint fk_product_id foreign key (product_id) references produits (product_id)
);

-- �crivez les requ�tes SQL appropri�es pour ins�rer tous les enregistrements fournis dans leurs tables correspondantes

insert into clients
(customer_id, nom_client, customer_tel)
values (1, 'Ahmed', 'Tunisie'),
(2, 'Coulibaly', 'S�n�gal'),
(3, 'Hasan', '�gypte'),
(4, 'Yasmine', 'Maroc'),
(5, 'John', 'France'),
(6, 'Fatima', 'Alg�rie');

insert into produits
(product_id, nom_produit, categorie, prix)
values (1, 'Biscuits', 'Snacks', 10), 
(2, 'Bonbons', 'Bonbons', 5.2),
(3, 'Chips', 'Snacks', 8.5),
(4, 'Jus', 'Boissons', 15),
(5, 'Glace', 'Desserts', 12);

insert into commande
(order_id, customer_id, product_id, quantit�, order_date)
values (1, 1, 2, 3, '2023-01-22'),
(2, 2, 1, 10, '2023-04-14'),
(3, 3, 4, 5, '2023-06-10'),
(4, 5, 3, 7, '2023-07-05'),
(5, 6, 5, 2, '2023-10-15');

-- Mettez � jour la quantit� de la deuxi�me commande, la nouvelle valeur devrait �tre 6.

update commande
set quantit� = 6
where order_id = 2;

--Supprimez le troisi�me client de la table des clients.

delete from clients
where customer_id = 3;

select*
from clients;

-- 1 Clients ayant command� � la fois des � Bonbons � et des � Biscuits � et le co�t total

SELECT c.nom_client, 
       SUM(p.prix * cmd.quantit�) AS co�t_total
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
JOIN produits p ON cmd.product_id = p.product_id
WHERE p.nom_produit = 'Bonbons'
   OR p.nom_produit = 'Biscuits'
GROUP BY c.nom_client
HAVING COUNT(DISTINCT p.nom_produit) = 2;

-- 2 Clients ayant command� des � Cookies � et le co�t total

SELECT c.nom_client, 
       SUM(p.prix * cmd.quantit�) AS co�t_total
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
JOIN produits p ON cmd.product_id = p.product_id
WHERE p.nom_produit = 'Biscuits'
GROUP BY c.nom_client;

-- 3 Clients ayant command� des � Bonbons � et le co�t total

SELECT c.nom_client, 
       SUM(p.prix * cmd.quantit�) AS co�t_total
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
JOIN produits p ON cmd.product_id = p.product_id
WHERE p.nom_produit = 'Bonbons'
GROUP BY c.nom_client;

-- 4 Clients ayant command� de la � glace � et le co�t total

SELECT c.nom_client, 
       SUM(p.prix * cmd.quantit�) AS co�t_total
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
JOIN produits p ON cmd.product_id = p.product_id
WHERE p.nom_produit = 'Glace'
GROUP BY c.nom_client;

-- 5 Total des � Biscuits � et � Bonbons � command�s par chaque client

SELECT c.nom_client, 
       SUM(cmd.quantit�) AS total_quantit�,
       SUM(p.prix * cmd.quantit�) AS co�t_total
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
JOIN produits p ON cmd.product_id = p.product_id
WHERE p.nom_produit = 'Biscuits' OR p.nom_produit = 'Bonbons'
GROUP BY c.nom_client;

-- 6 Noms des produits command�s et quantit� totale

SELECT p.nom_produit, 
       SUM(cmd.quantit�) AS total_quantit�
FROM produits p
JOIN commande cmd ON p.product_id = cmd.product_id
GROUP BY p.nom_produit;

-- 7 Clients ayant pass� le plus de commandes

SELECT c.nom_client, 
       COUNT(*) AS nombre_commandes
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
GROUP BY c.nom_client
ORDER BY nombre_commandes DESC;

-- 8 Produits les plus command�s et quantit� totale

SELECT p.nom_produit, 
       SUM(cmd.quantit�) AS total_quantit�
FROM produits p
JOIN commande cmd ON p.product_id = cmd.product_id
GROUP BY p.nom_produit
ORDER BY total_quantit� DESC;

-- 9 Clients ayant pass� une commande chaque jour de la semaine

SELECT c.nom_client, 
       COUNT(DISTINCT DATEPART(WEEKDAY, cmd.order_date)) AS jours_command�s
FROM clients c
JOIN commande cmd ON c.customer_id = cmd.customer_id
GROUP BY c.nom_client
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, cmd.order_date)) = 7;

