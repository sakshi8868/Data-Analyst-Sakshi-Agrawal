--50 more Orders

INSERT INTO orders (customer_id, order_date, status, total_amount) VALUES
(1, '2025-01-05', 'Completed', 0),
(2, '2025-01-08', 'Completed', 0),
(3, '2025-01-10', 'Pending', 0),
(4, '2025-01-15', 'Completed', 0),
(1, '2025-01-18', 'Cancelled', 0),
(2, '2025-01-22', 'Completed', 0),
(3, '2025-01-25', 'Completed', 0),
(4, '2025-02-01', 'Completed', 0),
(1, '2025-02-03', 'Pending', 0),
(2, '2025-02-05', 'Completed', 0),
(3, '2025-02-07', 'Completed', 0),
(4, '2025-02-10', 'Completed', 0),
(1, '2025-02-15', 'Completed', 0),
(2, '2025-02-18', 'Completed', 0),
(3, '2025-02-20', 'Cancelled', 0),
(4, '2025-02-25', 'Completed', 0),
(1, '2025-03-01', 'Completed', 0),
(2, '2025-03-03', 'Completed', 0),
(3, '2025-03-06', 'Pending', 0),
(4, '2025-03-08', 'Completed', 0),
(1, '2025-03-10', 'Completed', 0),
(2, '2025-03-12', 'Completed', 0),
(3, '2025-03-15', 'Completed', 0),
(4, '2025-03-18', 'Completed', 0),
(1, '2025-03-20', 'Cancelled', 0),
(2, '2025-03-22', 'Completed', 0),
(3, '2025-03-25', 'Completed', 0),
(4, '2025-03-28', 'Completed', 0),
(1, '2025-04-01', 'Completed', 0),
(2, '2025-04-03', 'Pending', 0),
(3, '2025-04-05', 'Completed', 0),
(4, '2025-04-07', 'Completed', 0),
(1, '2025-04-10', 'Completed', 0),
(2, '2025-04-12', 'Completed', 0),
(3, '2025-04-15', 'Completed', 0),
(4, '2025-04-18', 'Completed', 0),
(1, '2025-04-20', 'Completed', 0),
(2, '2025-04-22', 'Completed', 0),
(3, '2025-04-25', 'Pending', 0),
(4, '2025-04-28', 'Completed', 0),
(1, '2025-05-01', 'Completed', 0),
(2, '2025-05-03', 'Completed', 0),
(3, '2025-05-05', 'Completed', 0),
(4, '2025-05-08', 'Completed', 0),
(1, '2025-05-10', 'Completed', 0),
(2, '2025-05-12', 'Completed', 0),
(3, '2025-05-15', 'Cancelled', 0),
(4, '2025-05-18', 'Completed', 0),
(1, '2025-05-20', 'Completed', 0),
(2, '2025-05-22', 'Completed', 0);

--Orders 17–26
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(17, 1, 1, 699.99),
(17, 3, 2, 19.99),

(18, 2, 1, 1299.50),

(19, 3, 4, 19.99),

(20, 5, 1, 399.99),
(20, 6, 1, 149.99),

(21, 7, 3, 49.99),

(22, 8, 2, 29.99),

(23, 1, 1, 699.99),
(23, 6, 2, 149.99),

(24, 4, 5, 9.99),

(25, 2, 1, 1299.50),

(26, 5, 2, 399.99);

--Orders 27–36
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(27, 3, 3, 19.99),
(27, 7, 2, 49.99),

(28, 6, 1, 149.99),

(29, 1, 1, 699.99),

(30, 8, 3, 29.99),

(31, 5, 1, 399.99),

(32, 2, 1, 1299.50),
(32, 6, 1, 149.99),

(33, 7, 4, 49.99),

(34, 3, 5, 19.99),

(35, 1, 1, 699.99),

(36, 4, 2, 9.99);

--Orders 37-46
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(37, 5, 1, 399.99),
(37, 8, 2, 29.99),

(38, 6, 2, 149.99),

(39, 3, 3, 19.99),

(40, 2, 1, 1299.50),

(41, 7, 2, 49.99),

(42, 1, 1, 699.99),
(42, 6, 1, 149.99),

(43, 8, 4, 29.99),

(44, 5, 1, 399.99),

(45, 3, 6, 19.99),

(46, 2, 1, 1299.50);

--Orders 47-56
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(47, 7, 3, 49.99),

(48, 1, 1, 699.99),

(49, 6, 1, 149.99),

(50, 5, 2, 399.99),

(51, 3, 2, 19.99),

(52, 8, 3, 29.99),

(53, 2, 1, 1299.50),

(54, 1, 1, 699.99),

(55, 7, 5, 49.99),

(56, 5, 1, 399.99);

--Orders 57-66
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(57, 3, 3, 19.99),

(58, 6, 2, 149.99),

(59, 2, 1, 1299.50),

(60, 4, 4, 9.99),

(61, 1, 1, 699.99),

(62, 8, 2, 29.99),

(63, 5, 1, 399.99),

(64, 3, 4, 19.99),

(65, 6, 1, 149.99),

(66, 2, 1, 1299.50);

--Recalculate Order Totals
UPDATE orders o
SET total_amount = sub.total
FROM (
    SELECT order_id, SUM(quantity * price) AS total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id;

--Insert Payments for Completed Orders
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
AND order_id BETWEEN 17 AND 66;

