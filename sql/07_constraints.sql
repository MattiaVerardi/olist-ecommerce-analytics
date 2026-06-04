/*
Project: Olist Ecommerce Analytics
Description: Inserimento FK e CK
Author: Mattia Verardi
*/

use olist_ecommerce;
go

-- FK
alter table clean_orders
add foreign key(customer_id)
	references clean_customers(customer_id);
go

alter table clean_order_items
add foreign key(order_id)
		references clean_orders(order_id),
	foreign key(product_id)
		references clean_products(product_id),
	foreign key(seller_id)
		references clean_sellers(seller_id);
go

alter table clean_order_payments
add foreign key(order_id)
	references clean_orders(order_id);
go

alter table clean_order_reviews
add foreign key(order_id)
	references clean_orders(order_id);
go

-- CK
if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_orders_order_status'
	)
alter table clean_orders
drop constraint CK_clean_orders_order_status;
go

alter table clean_orders
add constraint CK_clean_orders_order_status
	check(
		order_status in(
			'delivered',
			'invoiced',
			'shipped',
			'processing',
			'unavailable',
			'canceled',
			'created',
			'approved'
			)
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_name_length'
	)
alter table clean_products
drop constraint CK_clean_products_product_name_length;
go

alter table clean_products
add constraint CK_clean_products_product_name_length
	check(
		product_name_length >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_description_length'
	)
alter table clean_products
drop constraint CK_clean_products_product_description_length
go

alter table clean_products
add constraint CK_clean_products_product_description_length
	check(
		product_description_length >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_photos_qty'
	)
alter table clean_products
drop constraint CK_clean_products_product_photos_qty
go

alter table clean_products
add constraint CK_clean_products_product_photos_qty
	check(
		product_photos_qty >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_weight_g'
	)
alter table clean_products
drop constraint CK_clean_products_product_weight_g
go

alter table clean_products
add constraint CK_clean_products_product_weight_g
	check(
		product_weight_g >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_length_cm'
	)
alter table clean_products
drop constraint CK_clean_products_product_length_cm
go

alter table clean_products
add constraint CK_clean_products_product_length_cm
	check(
		product_length_cm >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_height_cm'
	)
alter table clean_products
drop constraint CK_clean_products_product_height_cm
go

alter table clean_products
add constraint CK_clean_products_product_height_cm
	check(
		product_height_cm >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_products_product_width_cm'
	)
alter table clean_products
drop constraint CK_clean_products_product_width_cm
go

alter table clean_products
add constraint CK_clean_products_product_width_cm
	check(
		product_width_cm >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_items_price'
	)
alter table clean_order_items
drop constraint CK_clean_order_items_price
go

alter table clean_order_items
add constraint CK_clean_order_items_price
	check(
		price >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_items_freight_value'
	)
alter table clean_order_items
drop constraint CK_clean_order_items_freight_value
go

alter table clean_order_items
add constraint CK_clean_order_items_freight_value
	check(
		freight_value >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_payments_payment_type'
	)
alter table clean_order_payments
drop constraint CK_clean_order_payments_payment_type
go

alter table clean_order_payments
add constraint CK_clean_order_payments_payment_type
	check(
		payment_type in(
			'credit_card',
			'boleto',
			'voucher',
			'debit_card',
			'not_defined'
			)
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_payments_payment_value'
	)
alter table clean_order_payments
drop constraint CK_clean_order_payments_payment_value
go

alter table clean_order_payments
add constraint CK_clean_order_payments_payment_value
	check(
		payment_value >= 0
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_reviews_review_score'
	)
alter table clean_order_reviews
drop constraint CK_clean_order_reviews_review_score
go

alter table clean_order_reviews
add constraint CK_clean_order_reviews_review_score
	check(
		review_score between 1 and 5
		);
go

if exists(
	select 1
	from sys.check_constraints
	where name = 'CK_clean_order_reviews_creation_before_answer'
	)
alter table clean_order_reviews
drop constraint CK_clean_order_reviews_creation_before_answer
go

alter table clean_order_reviews
add constraint CK_clean_order_reviews_creation_before_answer
	check(
		review_creation_date <= review_answer_timestamp
		);
go