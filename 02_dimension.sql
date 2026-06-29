CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_sku VARCHAR(20),
    product_name VARCHAR(100),
    product_category VARCHAR(50)
);

INSERT INTO dim_product (product_sku, product_name, product_category)
SELECT DISTINCT product_sku, product_name, product_category
FROM raw_transactions;

SELECT * FROM dim_product;



create TABLE dim_customer (
    customer_key SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_city VARCHAR(50),
    customer_email VARCHAR(100)
);

insert into dim_customer (customer_name, customer_city, customer_email)
SELECT DISTINCT customer_name, customer_city, customer_email
FROM raw_transactions;

SELECT * FROM dim_customer;