--High Value Orders--

SELECT o.order_id, o.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE total_amount > 500
ORDER BY total_amount DESC;

--Products with high value--

SELECT product_id, name, price
FROM products
WHERE price > 500
ORDER BY price DESC;

--Revenue per category--

SELECT 
    c.name AS category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_revenue DESC;

--Average rating per product--

SELECT 
    p.name,
    COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.name
ORDER BY avg_rating DESC NULLS LAST;

--Top-selling products--

SELECT name
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM order_items
    GROUP BY product_id
    ORDER BY SUM(quantity) DESC
    LIMIT 2
);

--Most valuable customers--

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name
ORDER BY lifetime_value DESC;

--Ratings and revenue--

SELECT 
    p.name,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS revenue,
    COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.name
ORDER BY avg_rating DESC, revenue DESC;

--Orders per product--

SELECT 
    p.product_id,
    p.name AS product_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_ordered
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_quantity_ordered DESC;

--Revenue per product--

SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(COALESCE(oi.quantity, 0)) AS total_quantity_ordered,
    SUM(COALESCE(oi.quantity * oi.price, 0)) AS total_revenue
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

--Orders per category--

SELECT 
    c.name AS category_name,
    SUM(COALESCE(oi.quantity, 0)) AS total_quantity_ordered
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
LEFT JOIN order_items oi ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_quantity_ordered DESC;

--Revenue per category--

SELECT 
    c.category_id,
    c.name AS category_name,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_sales_value
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.name
ORDER BY total_sales_value DESC;

--Product-level Review Analysis--

SELECT 
    p.product_id,
    p.name AS product_name,
    COUNT(r.review_id) AS total_reviews,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    MAX(r.rating) AS highest_rating,
    MIN(r.rating) AS lowest_rating
FROM products p
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
ORDER BY avg_rating DESC NULLS LAST;

--Products-wise Profit Analysis--

SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity * p.cost_price) AS total_cost,
    SUM(oi.quantity * oi.price) - SUM(oi.quantity * p.cost_price) AS total_profit
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_profit DESC NULLS LAST;

--Category-wise Profit Analysis--

SELECT 
    c.name AS category_name,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity * p.cost_price) AS total_cost,
    SUM(oi.quantity * oi.price) - SUM(oi.quantity * p.cost_price) AS total_profit
FROM categories c
INNER JOIN products p ON c.category_id = p.category_id
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.name
ORDER BY total_profit DESC;

--Profit Margin % by Product--

SELECT 
    p.name,
    COALESCE(ROUND(
        (SUM(oi.quantity * oi.price) - SUM(oi.quantity * p.cost_price)) 
        / NULLIF(SUM(oi.quantity * oi.price),0) * 100, 
    2), 0) AS profit_margin_percentage
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY profit_margin_percentage DESC NULLS LAST;
