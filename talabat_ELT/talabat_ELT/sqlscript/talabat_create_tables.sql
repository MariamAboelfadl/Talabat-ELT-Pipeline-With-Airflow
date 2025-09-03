-- ==========================================
-- SCHEMA: Talabat-like (Products + Drivers separate)
-- ==========================================

DROP TABLE IF EXISTS reviews, payments, order_items, orders,
    products, restaurants, addresses, drivers, users CASCADE;

-- Users (generic info: login, contact)
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  user_type VARCHAR(20) NOT NULL, -- 'customer','restaurant','driver'
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  password_hash VARCHAR(200) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Addresses (linked to users)
CREATE TABLE addresses (
  address_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  street VARCHAR(200) NOT NULL,
  city VARCHAR(100) NOT NULL,
  zone VARCHAR(100),
  is_default BOOLEAN DEFAULT FALSE
);

-- Restaurants
CREATE TABLE restaurants (
  restaurant_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id), -- owner
  name VARCHAR(200) NOT NULL,
  address TEXT,
  cuisine VARCHAR(100),
  min_order DECIMAL(10,2) DEFAULT 0.00,
  delivery_fee DECIMAL(10,2) DEFAULT 0.00,
  is_open BOOLEAN DEFAULT TRUE
);

-- Products (menu items)
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id),
  category VARCHAR(100) NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  available BOOLEAN DEFAULT TRUE
);

-- Drivers
CREATE TABLE drivers (
  driver_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id),
  vehicle_type VARCHAR(50),     -- Bike, Car, Scooter
  license_number VARCHAR(50),
  is_active BOOLEAN DEFAULT TRUE,
  rating_avg DECIMAL(3,2) DEFAULT 5.00
);

-- Orders
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES users(user_id),
  restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id),
  driver_id INT REFERENCES drivers(driver_id),
  status VARCHAR(50) NOT NULL, -- placed, accepted, picked_up, delivered
  total_amount DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT NOW(),
  accepted_at TIMESTAMP,
  picked_up_at TIMESTAMP,
  delivered_at TIMESTAMP
);

-- Order Items
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(order_id),
  product_id INT NOT NULL REFERENCES products(product_id),
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
);

-- Payments
CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(order_id),
  amount DECIMAL(10,2) NOT NULL,
  method VARCHAR(50), -- cash, credit_card, wallet
  paid_at TIMESTAMP DEFAULT NOW()
);

-- Reviews
CREATE TABLE reviews (
  review_id SERIAL PRIMARY KEY,
  order_id INT NOT NULL REFERENCES orders(order_id),
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

