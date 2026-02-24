
--Create Sales Table
CREATE TABLE sales (
    order_id INT,
    product TEXT,
    quantity INT,
    price NUMERIC,
    order_date DATE
);

--Insert data onto the same
INSERT INTO sales (order_id, product, quantity, price, order_date)
SELECT 
    gs AS order_id,
    CASE 
        WHEN gs % 3 = 0 THEN 'Laptop'
        WHEN gs % 3 = 1 THEN 'Phone'
        ELSE 'Tablet'
    END AS product,
    (RANDOM() * 5 + 1)::INT AS quantity,
    CASE 
        WHEN gs % 3 = 0 THEN 60000
        WHEN gs % 3 = 1 THEN 20000
        ELSE 30000
    END AS price,
    CURRENT_DATE - (RANDOM() * 365)::INT AS order_date
FROM generate_series(1, 60) AS gs;

--Execute the dataset
SELECT * from sales;

