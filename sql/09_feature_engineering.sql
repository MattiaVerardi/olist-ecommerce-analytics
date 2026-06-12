/*
Project: Olist Ecommerce Analitycs
Description: Creazione delle seguenti feature, divise per
dataset:


ORDER ITEMS
- freight_ratio, che calcola il rapporto tra il costo della
	spedizione e il prezzo dell'articolo venduto, ossia quanto
	pesa il costo del trasporto sul prezzo dell'articolo

ORDERS
- order_purchase_year,
- order_purchase_month,
- order_purchase_day,
- order_purchase_weekday,
- order_purchase_quarter, che estraggono da
	order_purchase_timestamp, rispettivamente, anno, mese, giorno,
	giorno della settimana e trimestre
- order_approval_duration_hours, che calcola le ore che
	intercorrono tra la data di acquisto e la data di
	approvazione dell'ordine
- order_delivery_time_days, che calcola i giorni che
	intercorrono tra la data di acquisto e la data di
	consegna al cliente
- order_shipping_time_days, che calcola i giorni che
	intercorrono tra la consegna al corriere e 
	quella al cliente
- order_delivery_delay_days, che calcola i giorni di
	differenza tra la data di consegna effettiva e quella
	stimata. Se positivo, l'ordine è stato consegnato
	in ritardo; se negativo, l'ordine è stato consegnato prima
	del previsto
- order_delivery_on_time_flag, che assegna 1 a ordini
	consegnati in anticipo o in tempo e 0 a ordini
	consegnati in ritardo
- order_delivery_status, che distingue tempi di consegna
	super early (se minori di -7), early (se compresi tra -7
	e -1), on_time (se uguali a 0), delayed (se compresi tra
	1 e 7) e severely_delayed (se maggiori di 7)
- order_total_value, che associa ad ogni order_id la somma
	dei prezzi dei singoli articoli presi dalla tabella
	clean_order_items
- order_total_freight_value, che associa ad ogni order_id
	la somma del valore di trasporto dei singoli articoli
	presi dalla tabella clean_order_items
- order_total_freight_ratio, che calcola il rapporto tra il
	costo totale del trasporto e il valore totale dell'ordine,
	ossia quanto incide il primo sul secondo
- order_total_amount, che somma il valore totale dell'ordine e 
	il costo totale	di spedizione

N.B. Questa feature dovrebbe coincidere teoricamente con la
	colonna payment_value (opportunamente aggregata per	order_id)
	di clean_order_payments, che rappresenta il	valore della
	transazione. Tuttavia, esistono 576 record per i quali i due
	valori non coincidono, come emerso dal controllo di cui sotto.
	Infatti, order_total_amount	rappresenta il valore commerciale
	dell'ordine, mentre	la somma dei payment_value è il valore 
	realmente pagato dal cliente. Si nota, inoltre, che alcuni
	record presentano differenze sostanziali, non derivanti da
	arrotondamenti di pochi centesimi

select co.order_id,
	cop.order_id,
	cop.total_payment_value,
	(co.order_total_value + co.order_total_freight_value)
		as total_order_value
from(
	select order_id,
		sum(payment_value) as total_payment_value
	from clean_order_payments
	group by order_id
	) as cop
inner join clean_orders as co
	on cop.order_id = co.order_id
where cop.total_payment_value <>
	(co.order_total_value + co.order_total_freight_value);

- order_payment_gap, che calcola la differenza tra il valore
	pagato dal cliente, preso da clean_order_payments, e il
	valore commerciale dell'ordine. Se il valore è positivo, il
	cliente ha pagato di più rispetto a order_total_amount; se
	negativo, il cliente ha pagato di meno; se null, non c'è
	informazione di pagamento
- order_item_count, che conta quante volte un articolo è stato
	venduto per ogni ordine
- order_seller_count, che conta il numero di venditori univoci
	per ordine

ORDER REVIEWS
- review_answer_days, che calcola i giorni che intercorrono
	tra la data di invio del questionario e la data di risposta
	del cliente
	
Author: Mattia Verardi
*/

use olist_ecommerce;
go

-- ORDER ITEMS

-- Freight Ratio
if col_length('clean_order_items', 'freight_ratio') is null
	alter table clean_order_items
	add freight_ratio decimal(10,4);
go

update clean_order_items
set freight_ratio =
		case
			when price > 0
				then freight_value / price
			else null
		end;
go


-- ORDERS

-- Order Purchase Year
if col_length('clean_orders', 'order_purchase_year') is null
	alter table clean_orders
	add order_purchase_year int;
go

update clean_orders
set order_purchase_year =
		year(order_purchase_timestamp);
go

-- Order Purchase Month
if col_length('clean_orders', 'order_purchase_month') is null
	alter table clean_orders
	add order_purchase_month int;
go

update clean_orders
set order_purchase_month =
		month(order_purchase_timestamp);
go

-- Order Purchase Day
if col_length('clean_orders', 'order_purchase_day') is null
	alter table clean_orders
	add order_purchase_day int;
go

update clean_orders
set order_purchase_day =
		day(order_purchase_timestamp);
go

-- Order Purchase Weekday
set datefirst 1;
go

if col_length('clean_orders', 'order_purchase_weekday') is null
	alter table clean_orders
	add order_purchase_weekday int;
go

update clean_orders
set order_purchase_weekday =
		datepart(weekday, order_purchase_timestamp);
go

-- Order Purchase Quarter
if col_length('clean_orders', 'order_purchase_quarter') is null
	alter table clean_orders
	add order_purchase_quarter int;
go

update clean_orders
set order_purchase_quarter =
		datepart(quarter, order_purchase_timestamp);
go

-- Order Approval Duration Hours
if col_length('clean_orders', 'order_approval_duration_hours') is null
	alter table clean_orders
	add order_approval_duration_hours int;
go

update clean_orders
set order_approval_duration_hours =
		datediff(
			hour,
			order_purchase_timestamp,
			order_approved_at
			);
go

-- Order Delivery Time Days
if col_length('clean_orders', 'order_delivery_time_days') is null
	alter table clean_orders
	add order_delivery_time_days int;
go

update clean_orders
set order_delivery_time_days =
		datediff(
			day,
			order_purchase_timestamp,
			order_delivered_customer_date
			);
go

-- Order Shipping Time Days
if col_length('clean_orders', 'order_shipping_time_days') is null
	alter table clean_orders
	add order_shipping_time_days int;
go

update clean_orders
set order_shipping_time_days =
		datediff(
			day,
			order_delivered_carrier_date,
			order_delivered_customer_date
			);
go

-- Order Delivery Delay Days
if col_length('clean_orders', 'order_delivery_delay_days') is null
	alter table clean_orders
	add order_delivery_delay_days int;
go

update clean_orders
set order_delivery_delay_days =
		datediff(
			day,
			order_estimated_delivery_date,
			order_delivered_customer_date
			);
go

-- Order Delivery On Time Flag
if col_length('clean_orders', 'order_delivery_on_time_flag') is null
	alter table clean_orders
	add order_delivery_on_time_flag bit;
go

update clean_orders
set order_delivery_on_time_flag =
		case
			when order_delivery_delay_days <= 0
				then 1
			when order_delivery_delay_days > 0
				then 0
			else null
		end;
go

-- Order Delivery Status
if col_length('clean_orders', 'order_delivery_status') is null
	alter table clean_orders
	add order_delivery_status varchar(20);
go

update clean_orders
set order_delivery_status =
		case
			when order_delivery_delay_days < -7
				then 'super_early'
			when order_delivery_delay_days between -7 and -1 
				then 'early'
			when order_delivery_delay_days = 0
				then 'on_time'
			when order_delivery_delay_days between 1 and 7
				then 'delayed'
			when order_delivery_delay_days > 7
				then 'severely_delayed'
			else null
		end;
go

-- Order Total Value
if col_length('clean_orders', 'order_total_value') is null
	alter table clean_orders
	add order_total_value decimal(18,2);
go

with order_price as(
	select order_id,
		sum(price) as total_price
	from clean_order_items
	group by order_id
	)
update clean_orders
set order_total_value = op.total_price
from order_price as op
inner join clean_orders as co
	on op.order_id = co.order_id;

-- Order Total Freight Value
if col_length('clean_orders', 'order_total_freight_value') is null
	alter table clean_orders
	add order_total_freight_value decimal(18,2);
go

with order_freight_value as(
	select order_id,
		sum(freight_value) as total_freight_value
	from clean_order_items
	group by order_id
	)
update clean_orders
set order_total_freight_value = ofv.total_freight_value
from order_freight_value as ofv
inner join clean_orders as co
	on ofv.order_id = co.order_id;
go

-- Order Total Freight Ratio
if col_length('clean_orders', 'order_total_freight_ratio') is null
	alter table clean_orders
	add order_total_freight_ratio decimal(10,4);
go

update clean_orders
set order_total_freight_ratio =
		case
			when order_total_value > 0
				then order_total_freight_value /
					order_total_value
			else null
		end;
go

-- Order Total Amount
if col_length('clean_orders', 'order_total_amount') is null
	alter table clean_orders
	add order_total_amount decimal(18,2);
go

update clean_orders
set order_total_amount =
		order_total_value + order_total_freight_value;
go

-- Order Payment Gap
if col_length('clean_orders', 'order_payment_gap') is null
	alter table clean_orders
	add order_payment_gap decimal(18,2);
go

update clean_orders
set order_payment_gap =
		cop.total_payment_value - co.order_total_amount
from(
	select order_id,
		sum(payment_value) as total_payment_value
	from clean_order_payments
	group by order_id
	) as cop
inner join clean_orders as co
	on cop.order_id = co.order_id;

-- Order Item Count
if col_length('clean_orders', 'order_item_count') is null
	alter table clean_orders
	add order_item_count int;
go

with order_items_count as(
	select order_id,
		count(*) as items_per_order
	from clean_order_items
	group by order_id
	)
update clean_orders
set order_item_count = oic.items_per_order
from order_items_count as oic
inner join clean_orders as co
	on oic.order_id = co.order_id;
go

-- Order Seller Count
if col_length('clean_orders', 'order_seller_count') is null
	alter table clean_orders
	add order_seller_count int;
go

with sellers_count as(
	select order_id,
		count(distinct seller_id) as seller_per_order
	from clean_order_items
	group by order_id
	)
update clean_orders
set order_seller_count = sc.seller_per_order
from sellers_count as sc
inner join clean_orders as co
	on sc.order_id = co.order_id;
go


-- ORDER REVIEWS

-- Review Answer Days
if col_length('clean_order_reviews', 'review_answer_days') is null
	alter table clean_order_reviews
	add review_answer_days int;
go

update clean_order_reviews
set review_answer_days =
		datediff(
			day,
			review_creation_date,
			review_answer_timestamp
			);
go




