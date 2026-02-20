--Monthly revenue analysis
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM orders
WHERE status = 'Completed'
GROUP BY year, month
ORDER BY year, month;

--Revenue by month
SELECT 
    DATE(DATE_TRUNC('month', order_date)) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
AND order_date >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY month
ORDER BY month;

--Current year monthly trend
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
AND DATE_TRUNC('year', order_date) = DATE_TRUNC('year', CURRENT_DATE)
GROUP BY month
ORDER BY month;

--Previous year analysis
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
AND DATE_TRUNC('year', order_date) = 
    DATE_TRUNC('year', CURRENT_DATE - INTERVAL '1 year')
GROUP BY month
ORDER BY month;

--Last 3 years trend
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
AND order_date >= CURRENT_DATE - INTERVAL '3 years'
GROUP BY year
ORDER BY year;

--Current quarter analysis
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Completed'
AND DATE_TRUNC('quarter', order_date) = 
    DATE_TRUNC('quarter', CURRENT_DATE);

--Rolling 6-month profit trend
SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity * p.cost_price) AS total_cost,
    SUM(oi.quantity * oi.price) - SUM(oi.quantity * p.cost_price) AS total_profit
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
AND o.order_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY month
ORDER BY month;

--Year-to-Date (YTD) analysis
SELECT 
    COUNT(DISTINCT order_id) AS ytd_orders,
    SUM(total_amount) AS ytd_revenue
FROM orders
WHERE status = 'Completed'
AND order_date >= DATE_TRUNC('year', CURRENT_DATE);

