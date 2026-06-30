CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP,
    customer_key INT,
    product_key INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    total_amount DECIMAL(10, 2)
);

INSERT INTO fact_sales (order_date, customer_key, product_key, quantity, unit_price, total_amount)
SELECT 
    r.order_date,
    c.customer_key,
    p.product_key,
    r.quantity,
    r.unit_price,
    (r.quantity * r.unit_price) AS total_amount
FROM raw_transactions r
JOIN dim_customer c ON r.customer_email = c.customer_email
JOIN dim_product p ON r.product_sku = p.product_sku;

SELECT * FROM fact_sales;



select a.product_category, sum(b.total_amount) as total_amount
from dim_product a
join fact_sales b on 
a.product_key = b.product_key
group by a.product_category 
order by total_amount desc;


select b.is_weekend , sum(a.total_amount) AS total_amount
 from fact_sales a
join dim_date b on
    a.order_date::date = b.full_date
    GROUP BY b.is_weekend
    order by total_amount desc;