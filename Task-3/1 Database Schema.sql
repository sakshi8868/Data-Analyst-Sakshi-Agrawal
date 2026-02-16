-- =========================
-- 0. e-Commerce Database
-- =========================
CREATE DATABASE ecommerce
  OWNER = postgres
  TEMPLATE = template0
  ENCODING = 'UTF8'
  LC_COLLATE = 'en_US.UTF-8'
  LC_CTYPE = 'en_US.UTF-8'
  TABLESPACE = pg_default
  CONNECTION LIMIT = -1;

-- =========================
-- 1. Categories Table
-- =========================
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- =========================
-- 2. Products Table
-- =========================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL REFERENCES categories(category_id) ON DELETE CASCADE,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 3. Inventory Table
-- =========================
CREATE TABLE inventory (
    product_id INT PRIMARY KEY REFERENCES products(product_id) ON DELETE CASCADE,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 4. Customers Table
-- =========================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 5. Orders Table
-- =========================
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    total_amount NUMERIC(12, 2) CHECK (total_amount >= 0)
);

-- =========================
-- 6. Order Items Table
-- =========================
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

-- =========================
-- 7. Payments Table
-- =========================
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) DEFAULT 'Completed'
);

-- =========================
-- 8. Reviews Table
-- =========================
CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id) ON DELETE CASCADE,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
