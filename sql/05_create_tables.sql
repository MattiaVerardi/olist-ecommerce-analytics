/*
Project: Olist Ecommerce Analytics
Description: Creazione tabelle per il successivo import
	dei dati
Author: Mattia Verardi
*/

use olist_ecommerce;
go

-- Orders
if object_id('clean_orders', 'u') is not null
	drop table clean_orders;
go

create table clean_orders(
	order_id char(32) primary key,
	customer_id char(32) not null,
	order_status varchar(15) not null,
	order_purchase_timestamp datetime not null,
	order_approved_at datetime,
	order_delivered_carrier_date datetime,
	order_delivered_customer_date datetime,
	order_estimated_delivery_date datetime not null
	);
go

-- Customers
if object_id('clean_customers', 'u') is not null
	drop table clean_customers;
go

create table clean_customers(
	customer_id char(32) primary key,
	customer_unique_id char(32) not null,
	customer_zip_code_prefix char(5) not null,
	customer_city varchar(50) not null,
	customer_state char(2) not null
	);
go

-- Geolocation
if object_id('clean_geolocation', 'u') is not null
	drop table clean_geolocation;
go

create table clean_geolocation(
	geolocation_zip_code_prefix char(5) not null,
	geolocation_lat decimal(9,6) not null,
	geolocation_lng decimal(9,6) not null,
	geolocation_city varchar(50) not null,
	geolocation_state char(2) not null
	);
go

-- Sellers
if object_id('clean_sellers', 'u') is not null
	drop table clean_sellers;
go

create table clean_sellers(
	seller_id char(32) primary key,
	seller_zip_code_prefix char(5) not null,
	seller_city varchar(50) not null,
	seller_state char(2) not null
	);
go

-- Products
if object_id('clean_products', 'u') is not null
	drop table clean_products;
go

create table clean_products(
	product_id char(32) primary key,
	product_category_name varchar(50),
	product_name_length int,
	product_description_length int,
	product_photos_qty int,
	product_weight_g decimal(10,2),
	product_length_cm decimal(10,2),
	product_height_cm decimal(10,2),
	product_width_cm decimal(10,2)
	);

-- Category Name Translation
if object_id('clean_category_name_translation', 'u') is not null
	drop table clean_category_name_translation;
go

create table clean_category_name_translation(
	product_category_name varchar(50) primary key,
	product_category_name_english varchar(50) not null
	);
go

-- Order Items
if object_id('clean_order_items', 'u') is not null
	drop table clean_order_items;
go

create table clean_order_items(
	order_id char(32),   
	order_item_id int,
	product_id char(32) not null,
	seller_id char(32) not null,
	shipping_limit_date datetime not null,
	price decimal(18,2) not null,
	freight_value decimal(18,2) not null,
	primary key(order_id, order_item_id)
	);
go

-- Order Payments
if object_id('clean_order_payments', 'u') is not null
	drop table clean_order_payments;
go

create table clean_order_payments(
	order_id char(32),
	payment_sequential int,
	payment_type varchar(15) not null,
	payment_installments int not null,
	payment_value decimal(18,2) not null,
	primary key(order_id, payment_sequential)
	);
go

-- Order Reviews
if object_id('clean_order_reviews', 'u') is not null
	drop table clean_order_reviews;
go

create table clean_order_reviews(
	review_id char(32),
	order_id char(32),
	review_score int not null,
	review_comment_title varchar(30),
	review_comment_message varchar(250),
	review_creation_date datetime not null,
	review_answer_timestamp datetime not null,
	primary key(review_id, order_id)
	);
go