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
│ Column                         │ Type     │ Description                   │
├────────────────────────────────┼──────────┼───────────────────────────────│
│ order_id                       │ string   │ Identificativo univoco ordine │
│ customer_id                    │ string   │ Identificativo cliente        │
│ order_status                   │ string   │ Stato dell’ordine             │
│ order_purchase_timestamp       │ datetime │ Data acquisto ordine          │
│ order_approved_at              │ datetime │ Data approvazione ordine      │
│ order_delivered_carrier_date   │ datetime │ Data consegna al corriere     │
│ order_delivered_customer_date  │ datetime │ Data consegna al cliente      │
│ order_estimated_delivery_date  │ datetime │ Data stimata di consegna      │
```

### Notes:
- valori null nelle colonne order_approved_at e order_delivered_*



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
| Column                   | Type   | Description |
|--------------------------|--------|-------------|
| customer_id              | string | Identificativo codice cliente |
| customer_unique_id       | string | Identificativo univoco cliente |
| customer_zip_code_prefix | int    | Prefisso del codice postale del cliente |
| customer_city       	   | string | Città del cliente |
| customer_state           | string | Stato del cliente |
```

### Notes:
- customer_id assegna un codice cliente per ogni ordine, anche se effettuato dallo stesso cliente
- customer_unique_id assegna un codice univoco ad ogni cliente
- per ogni customer_unique_id ci possono essere più customer_id
- è possibile associare customer_zip_code_prefix a geolocation.geolocation_zip_code_prefix



# Table: geolocation

### Business meaning:
Contiene informazioni per ogni codice postale brasiliano con relative coordinate

### Granularity:
più righe per lo stesso geolocation_zip_code_prefix

### PK:

### FK:

### Columns:
```
| Column                      | Type    | Description |
|-----------------------------| --------|-------------|
| geolocation_zip_code_prefix |	int     | Prefisso del codice postale |
| geolocation_lat	      | decimal | Latitudine |
| geolocation_lng             | decimal | Longitudine |
| geolocation_city            | string  | Città |
| geolocation_state           | string  | Stato |
```

### Notes:
- il dataset contiene righe duplicate
- geolocation_lat e geolocation_lng presentano anche valori negativi
- è possibile associare geolocation_zip_code_prefix a customers.customer_zip_code_prefix e a sellers.seller_zip_code_prefix



## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes:


 
## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes:


 
## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes:


 
## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes:


 
## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes:



## Table:

### Business meaning:

### Granularity:

### PK:

### FK:

### Columns:

### Notes: