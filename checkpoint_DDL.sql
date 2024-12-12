create database CHECKPOINT_DDL;

use CHECKPOINT_DDL;

create table clients (
	customer_id int primary key,
	nom_client varchar (30) not null,
	customer_tel varchar (50) not null,
);

create table produits (
	product_id int primary key,
	nom_produit varchar (50) not null,
	categorie varchar (30) not null,
	prix decimal not null,
);

create table commande (
	order_id int primary key,
	customer_id int not null,
	product_id int not null,
	quantité int not null,
	order_date date not null,
	constraint fk_customer_id foreign key (customer_id) references clients (customer_id),
	constraint fk_product_id foreign key (product_id) references produits (product_id)
);