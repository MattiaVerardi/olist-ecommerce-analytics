/*
Project: Olist Ecommerce Analytics
Description: Import dei file .csv
Author: Mattia Verardi
*/

use olist_ecommerce;
go

-- NOTA: AGGIORNA IL PATH IN BASE AL TUO AMBIENTE LOCALE

-- Orders
if object_id('clean_orders', 'u') is not null
	truncate table clean_orders;
go

bulk insert clean_orders
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_orders.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Customers
if object_id('clean_customers', 'u') is not null
	truncate table clean_customers;
go

bulk insert clean_customers
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_customers.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Geolocation
if object_id('clean_geolocation', 'u') is not null
	truncate table clean_geolocation;
go

bulk insert clean_geolocation
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_geolocation.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Sellers
if object_id('clean_sellers', 'u') is not null
	truncate table clean_sellers;
go

bulk insert clean_sellers
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_sellers.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Products
if object_id('clean_products', 'u') is not null
	truncate table clean_products;
go

bulk insert clean_products
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_products.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Category Name Translation
if object_id('clean_category_name_translation', 'u') is not null
	truncate table clean_category_name_translation;
go

bulk insert clean_category_name_translation
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_category_name_translation.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Order Items
if object_id('clean_order_items', 'u') is not null
	truncate table clean_order_items;
go

bulk insert clean_order_items
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_order_items.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Order Payments
if object_id('clean_order_payments', 'u') is not null
	truncate table clean_order_payments;
go

bulk insert clean_order_payments
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_order_payments.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go

-- Order Reviews
if object_id('clean_order_reviews', 'u') is not null
	truncate table clean_order_reviews;
go

bulk insert clean_order_reviews
from 'C:\Users\User\Desktop\DATA ANALYST\PROGETTI\olist-ecommerce-analytics\data\processed\clean_order_reviews.csv'
with(
	format= 'csv',
	firstrow = 2,
	fieldterminator = '\t',
	rowterminator = '0x0d0a',
	codepage='65001',
	tablock
	);
go