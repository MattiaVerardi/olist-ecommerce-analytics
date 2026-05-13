# Table: orders

### Business meaning:
Questo è il core del dataset e contiene informazioni sugli ordini effettuati

### Granularity:
1 riga = 1 ordine

### PK:
order_id

### FK:
customer_id -> customers.customer_id

### Columns:
```
| Column                        | Type     | Description                        |
|-------------------------------|----------|------------------------------------|
| order_id                      | string   | Identificativo univoco dell'ordine |
| customer_id                   | string   | Identificativo cliente             |
| order_status                  | string   | Stato dell’ordine                  |
| order_purchase_timestamp      | datetime | Data acquisto ordine               |
| order_approved_at             | datetime | Data approvazione ordine           |
| order_delivered_carrier_date  | datetime | Data consegna al corriere          |
| order_delivered_customer_date | datetime | Data consegna al cliente           |
| order_estimated_delivery_date | datetime | Data stimata di consegna           |
```

### Notes:
* order_status contiene 8 valori distinti (delivered, invoiced, shipped, processing, unavailable, canceled, created, approved)



# Table: customers

### Business meaning:
Contiene informazioni sui clienti e sulla loro posizione geografica

### Granularity:
1 riga = 1 customer_id

### PK:
customer_id

### FK:

### Columns:
```
| Column                   | Type   | Description                             |
|--------------------------|--------|-----------------------------------------|
| customer_id              | string | Codice cliente univoco                  |
| customer_unique_id       | string | Identificativo univoco del cliente      |
| customer_zip_code_prefix | int    | Prefisso del codice postale del cliente |
| customer_city       	   | string | Città del cliente                       |
| customer_state           | string | Stato del cliente                       |
```

### Notes:
* customer_id assegna un codice cliente per ogni ordine, anche se effettuato dallo stesso cliente
* customer_unique_id assegna un codice univoco ad ogni cliente
* per ogni customer_unique_id ci possono essere più customer_id
* è possibile associare customer_zip_code_prefix a geolocation.geolocation_zip_code_prefix



# Table: geolocation

### Business meaning:
Contiene informazioni per ogni codice postale brasiliano con relative coordinate

### Granularity:
più righe per lo stesso geolocation_zip_code_prefix

### PK:

### FK:

### Columns:
```
| Column                      | Type    | Description                 |
|-----------------------------|---------|-----------------------------|
| geolocation_zip_code_prefix |	int     | Prefisso del codice postale |
| geolocation_lat	      | decimal | Latitudine                  |
| geolocation_lng             | decimal | Longitudine                 |
| geolocation_city            | string  | Città                       |
| geolocation_state           | string  | Stato                       |
```

### Notes:
* è possibile associare geolocation_zip_code_prefix a customers.customer_zip_code_prefix e a sellers.seller_zip_code_prefix



# Table: sellers

### Business meaning:
Contiene informazioni riguardanti i venditori che hanno evaso gli ordini effettuati sull'e-commerce

### Granularity:
1 riga = 1 venditore

### PK:
seller_id

### FK:

### Columns:
```
| Column                 | Type   | Description                               |
|------------------------|--------|-------------------------------------------|
| seller_id              | string | Identificativo univoco del venditore      |
| seller_zip_code_prefix | int    | Prefisso del codice postale del venditore |
| seller_city            | string | Città del venditore                       |
| seller_state           | string | Stato del venditore                       |
```

### Notes:
* è possibile associare seller_zip_code_prefix a geolocation.geolocation_zip_code_prefix



# Table: products

### Business meaning:
Contiene informazioni riguardo i prodotti venduti sull'e-commerce

### Granularity:
1 riga = 1 prodotto

### PK:
product_id

### FK:

### Columns:
```
| Column                     | Type    | Description                              |
|----------------------------|---------|------------------------------------------|
| product_id                 | string  | Identificativo univoco del prodotto      |
| product_category_name      | string  | Categoria del prodotto                   |
| product_name_lenght        | int     | Caratteri del nome del prodotto          |
| product_description_lenght | int     | Caratteri della descrizione del prodotto |
| product_photos_qty         | int     | Foto pubblicate del prodotto             |
| product_weight_g           | decimal | Peso in grammi del prodotto              |
| product_length_cm          | decimal | Lunghezza in centimetri del prodotto     |
| product_height_cm          | decimal | Altezza in centimetri del prodotto       |
| product_width_cm           | decimal | Larghezza in centimetri del prodotto     |
```

### Notes:
* la categoria dei prodotti in product_category_name è in lingua portoghese



# Table: category_name_translation

### Business meaning:
Contiene le traduzioni dei nomi di categoria dei prodotti da portoghese ad inglese

### Granularity:
1 riga = 1 categoria

### PK:
product_category_name

### FK:

### Columns:
```
| Column                        | Type   | Description                       |
|-------------------------------|--------|-----------------------------------|
| product_category_name         | string | Categoria del prodotto            |
| product_category_name_english | string | Categoria del prodotto in inglese |
```

### Notes:
* è possibile collegare product_category_name con products.product_category_name


 
# Table: order_items

### Business meaning:
Contiene informazioni riguardo gli articoli venduti

### Granularity:
1 riga = 1 articolo venduto

### PK:
(order_id, order_item_id)

### FK:
order_id -> orders.order_id  
product_id -> products.product_id  
seller_id -> sellers.seller_id

### Columns:
```
| Column              | Type     | Description                                |
|---------------------|----------|--------------------------------------------|
| order_id            | string   | Identificativo univoco dell'ordine         |
| order_item_id       | int      | Identificativo sequenziale dell'articolo   |
| product_id          | string   | Identificativo univoco prodotto            |
| seller_id           | string   | Identificativo univoco venditore           |
| shipping_limit_date | datetime | Data limite di spedizione per il venditore |
| price               | decimal  | Prezzo dell'articolo                       |
| freight_value	      | decimal  | Valore di trasporto dell'articolo          |
```

### Notes:
* uno stesso order_id può avere più articoli, identificati univocamente con un numero sequenziale da order_item_id
* se un order_id ha più di un order_item_id, il freight_value totale viene suddiviso tra i vari articoli



# Table: order_payments

### Business meaning:
Contiene informazioni riguardo le opzioni di pagamento degli ordini

### Granularity:
1 riga = 1 transazione di pagamento

### PK:
(order_id, payment_sequential)

### FK:
order_id -> orders.order_id

### Columns:
```
| Column               | Type    | Description                                        |
|----------------------|---------|----------------------------------------------------|
| order_id             | string  | Identificativo univoco dell'ordine                 |
| payment_sequential   | int     | Identificativo sequenziale dei metodi di pagamento |
| payment_type         | string  | Metodo di pagamento                                |
| payment_installments | int     | Numero di rate                                     |
| payment_value        | decimal | Valore della transazione                           |
```

### Notes:
* se un cliente sceglie di pagare un ordine con più di un metodo di pagamento, payment_sequential rappresenta il numero sequenziale dei metodi scelti
* la colonna payment_type contiene 5 valori distinti (credit_card, boleto, voucher, debit_card, not_defined)
* se payment_installments è 1, il cliente ha pagato in un'unica soluzione


 
# Table: order_reviews

### Business meaning:
Contiene informazioni riguardo le recensioni dei clienti

### Granularity:
1 riga = 1 recensione per ordine

### PK:
(review_id, order_id)

### FK:
order_id -> orders.order_id

### Columns:
```
| Column                  | Type     | Description                                  |
|-------------------------|----------|----------------------------------------------|
| review_id               | string   | Identificativo univoco della recensione      |
| order_id                | string   | Identificativo univoco dell'ordine           |
| review_score            | int      | Punteggio della recensione                   |
| review_comment_title    | string   | Titolo della recensione                      |
| review_comment_message  | string   | Messaggio della recensione                   |
| review_creation_date    | datetime | Data di invio del questionario               |
| review_answer_timestamp | datetime | Data e ora di risposta al questionario       |
```

### Notes:
* la colonna review_score va da 1 a 5
* le colonne review_comment_title e review_comment_message sono in lingua portoghese