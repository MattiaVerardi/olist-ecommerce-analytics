/*
Project: Olist Ecommerce Analytics
Description: Creazione indexes
Author: Mattia Verardi
*/

use olist_ecommerce;
go

-- Orders
if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_orders_customer_id'
	)
drop index IX_clean_orders_customer_id
on clean_orders;
go

create index IX_clean_orders_customer_id
on clean_orders(customer_id);
go

-- Order Items
if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_order_items_order_id'
	)
drop index IX_clean_order_items_order_id
on clean_order_items;
go

create index IX_clean_order_items_order_id
on clean_order_items(order_id);
go

if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_order_items_product_id'
	)
drop index IX_clean_order_items_product_id
on clean_order_items;
go

create index IX_clean_order_items_product_id
on clean_order_items(product_id);
go

if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_order_items_seller_id'
	)
drop index IX_clean_order_items_seller_id
on clean_order_items;
go

create index IX_clean_order_items_seller_id
on clean_order_items(seller_id);
go

-- Order Payments
if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_order_payments_order_id'
	)
drop index IX_clean_order_payments_order_id
on clean_order_payments;
go

create index IX_clean_order_payments_order_id
on clean_order_payments(order_id);
go

-- Order Reviews
if exists(
	select 1
	from sys.indexes
	where name = 'IX_clean_order_reviews_order_id'
	)
drop index IX_clean_order_reviews_order_id
on clean_order_reviews;
go

create index IX_clean_order_reviews_order_id
on clean_order_reviews(order_id);
go