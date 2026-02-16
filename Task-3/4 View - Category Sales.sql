-- ==========================
-- Category-level Sales View
-- ==========================

CREATE OR REPLACE VIEW category_sales_analysis AS
SELECT 
    c.category_id,
    c.name AS category_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.name;

SELECT * FROM category_sales_analysis;
