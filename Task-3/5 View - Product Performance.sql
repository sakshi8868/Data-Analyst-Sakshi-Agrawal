-- ====================================
-- Product Performance View
-- ====================================

CREATE OR REPLACE VIEW product_performance AS
SELECT 
    p.product_id,
    p.name,
    COALESCE(SUM(oi.quantity), 0) AS total_sold,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue,
    COALESCE(ROUND(AVG(r.rating),2), 0) AS avg_rating
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;

SELECT * FROM product_performance;
