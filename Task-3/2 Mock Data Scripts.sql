
-- =========================
-- Sample Data
-- =========================
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic gadgets and devices'),
('Clothing', 'Men and Women clothing'),
('Books', 'Fiction and Non-fiction books');

INSERT INTO products (category_id, name, description, price) VALUES
(1, 'Smartphone', 'Latest Android smartphone', 699.99),
(1, 'Laptop', 'High performance laptop', 1299.50),
(2, 'T-Shirt', 'Cotton T-shirt', 19.99),
(3, 'Novel', 'Bestselling novel', 9.99);

INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 50),
(2, 20),
(3, 100),
(4, 200);

INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('John', 'Doe', 'john@example.com', '1234567890', '123 Main St'),
('Jane', 'Smith', 'jane@example.com', '9876543210', '456 Park Ave');

INSERT INTO orders (customer_id, status, total_amount) VALUES
(1, 'Pending', 719.98),
(2, 'Completed', 19.99);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 3, 1, 19.99);

INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(2, 19.99, 'Credit Card', 'Completed');

INSERT INTO reviews (product_id, customer_id, rating, comment) VALUES
(1, 1, 5, 'Excellent phone!'),
(3, 2, 4, 'Good quality T-shirt.');

INSERT INTO products (category_id, name, description, price) VALUES
(1, 'Tablet', '10-inch Android tablet', 399.99),
(1, 'Wireless Earbuds', 'Bluetooth noise-cancelling earbuds', 149.99),
(2, 'Jeans', 'Slim fit denim jeans', 49.99),
(3, 'Science Book', 'Educational science reference book', 29.99);

INSERT INTO inventory (product_id, stock_quantity) VALUES
(5, 40),   -- Tablet
(6, 75),   -- Earbuds
(7, 120),  -- Jeans
(8, 150);  -- Science Book

INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('Michael', 'Brown', 'michael@example.com', '1112223333', '789 Lake View'),
('Emily', 'Davis', 'emily@example.com', '4445556666', '321 Hill Road');

INSERT INTO orders (customer_id, status, total_amount) VALUES
(3, 'Completed', 549.98),
(4, 'Completed', 199.98);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(3, 5, 1, 399.99),   -- Tablet
(3, 7, 3, 49.99);    -- Jeans

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(4, 6, 1, 149.99),   -- Earbuds
(4, 8, 2, 29.99);    -- Science Book

INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(3, 549.98, 'Debit Card', 'Completed'),
(4, 199.98, 'UPI', 'Completed');

INSERT INTO reviews (product_id, customer_id, rating, comment) VALUES
(5, 3, 4, 'Very good tablet for the price.'),
(7, 3, 5, 'Perfect fit and comfortable jeans.'),
(6, 4, 3, 'Sound quality is decent but battery could be better.'),
(8, 4, 5, 'Excellent reference book for students.');

UPDATE products SET cost_price = 520.00 WHERE name = 'Smartphone';
UPDATE products SET cost_price = 1000.00 WHERE name = 'Laptop';
UPDATE products SET cost_price = 280.00 WHERE name = 'Tablet';
UPDATE products SET cost_price = 95.00 WHERE name = 'Wireless Earbuds';

UPDATE products SET cost_price = 10.00 WHERE name = 'T-Shirt';
UPDATE products SET cost_price = 25.00 WHERE name = 'Jeans';
UPDATE products SET cost_price = 4.50 WHERE name = 'Novel';
UPDATE products SET cost_price = 12.00 WHERE name = 'Science Book';

INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, NOW() - INTERVAL '15 days', 'Completed', 0),
(2, NOW() - INTERVAL '14 days', 'Completed', 0),
(3, NOW() - INTERVAL '12 days', 'Pending', 0),
(4, NOW() - INTERVAL '10 days', 'Completed', 0),
(1, NOW() - INTERVAL '9 days',  'Cancelled', 0),
(2, NOW() - INTERVAL '8 days',  'Completed', 0),
(3, NOW() - INTERVAL '7 days',  'Completed', 0),
(4, NOW() - INTERVAL '6 days',  'Pending', 0),
(1, NOW() - INTERVAL '5 days',  'Completed', 0),
(2, NOW() - INTERVAL '4 days',  'Completed', 0),
(3, NOW() - INTERVAL '3 days',  'Completed', 0),
(4, NOW() - INTERVAL '1 day',   'Completed', 0);

INSERT INTO order_items VALUES
(DEFAULT, 5, 1, 2, 1299.50); -- Laptop

INSERT INTO order_items VALUES
(DEFAULT, 6, 6, 2, 149.99),
(DEFAULT, 6, 3, 4, 19.99);

INSERT INTO order_items VALUES
(DEFAULT, 7, 1, 1, 699.99);

INSERT INTO order_items VALUES
(DEFAULT, 8, 7, 2, 49.99),
(DEFAULT, 8, 8, 1, 29.99);

INSERT INTO order_items VALUES
(DEFAULT, 9, 5, 1, 399.99);

INSERT INTO order_items VALUES
(DEFAULT, 10, 2, 1, 1299.50);

INSERT INTO order_items VALUES
(DEFAULT, 11, 6, 1, 149.99);

INSERT INTO order_items VALUES
(DEFAULT, 12, 4, 3, 9.99);

INSERT INTO order_items VALUES
(DEFAULT, 13, 5, 1, 399.99),
(DEFAULT, 13, 6, 1, 149.99);

INSERT INTO order_items VALUES
(DEFAULT, 14, 7, 2, 49.99);

INSERT INTO order_items VALUES
(DEFAULT, 15, 1, 1, 699.99);

INSERT INTO order_items VALUES
(DEFAULT, 16, 3, 5, 19.99);

UPDATE orders o
SET total_amount = sub.total
FROM (
    SELECT order_id, SUM(quantity * price) AS total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id;

INSERT INTO payments (order_id, payment_date, amount, payment_method, status)
SELECT 
    order_id,
    order_date + INTERVAL '1 day',
    total_amount,
    CASE 
        WHEN order_id % 3 = 0 THEN 'UPI'
        WHEN order_id % 3 = 1 THEN 'Credit Card'
        ELSE 'Debit Card'
    END,
    'Completed'
FROM orders
WHERE status = 'Completed'
AND order_id >= 5;
