

-- 1. Customers (1000)
INSERT INTO users (user_type, name, email, phone, password_hash)
SELECT 'customer',
       'Customer ' || g,
       'customer' || g || '@mail.com',
       '+2010' || (10000000 + g),
       'hashed_pw' || g
FROM generate_series(1, 1000) g;

-- 2. Restaurants (50 owners)
INSERT INTO users (user_type, name, email, phone, password_hash)
SELECT 'restaurant',
       'RestOwner ' || g,
       'rest' || g || '@mail.com',
       '+2020' || (20000000 + g),
       'hashed_rest' || g
FROM generate_series(1, 50) g;

INSERT INTO restaurants (user_id, name, address, cuisine, min_order, delivery_fee)
SELECT user_id,
       'Restaurant ' || user_id,
       'Street ' || user_id || ', Cairo',
       (ARRAY['Italian','Egyptian','Indian','Fast Food','Desserts'])[floor(random()*5)+1],
       round((random()*100 + 50)::numeric,2),
       round((random()*20 + 5)::numeric,2)
FROM users WHERE user_type='restaurant';

-- 3. Products (10 per restaurant)
INSERT INTO products (restaurant_id, category, name, description, price)
SELECT r.restaurant_id,
       (ARRAY['Main Dishes','Drinks','Desserts'])[floor(random()*3)+1],
       'Product ' || g,
       'Tasty product ' || g,
       round((random()*150 + 20)::numeric,2)
FROM restaurants r, generate_series(1,10) g;

-- 4. Drivers (100)
INSERT INTO users (user_type, name, email, phone, password_hash)
SELECT 'driver',
       'Driver ' || g,
       'driver' || g || '@mail.com',
       '+2011' || (30000000 + g),
       'hashed_drv' || g
FROM generate_series(1, 100) g;

INSERT INTO drivers (user_id, vehicle_type, license_number, is_active, rating_avg)
SELECT user_id,
       (ARRAY['Bike','Car','Scooter'])[floor(random()*3)+1],
       'LIC' || user_id,
       TRUE,
       round((random()*2+3)::numeric,2) -- avg rating 3.00–5.00
FROM users WHERE user_type='driver';

-- 5. Orders (1000)
INSERT INTO orders (customer_id, restaurant_id, driver_id, status, total_amount, created_at, accepted_at, picked_up_at, delivered_at)
SELECT
    (SELECT user_id FROM users WHERE user_type='customer' ORDER BY random() LIMIT 1),
    (SELECT restaurant_id FROM restaurants ORDER BY random() LIMIT 1),
    (SELECT driver_id FROM drivers ORDER BY random() LIMIT 1),
    (ARRAY['placed','accepted','preparing','picked_up','delivered'])[floor(random()*5)+1],
    round((random()*300 + 50)::numeric,2),
    NOW() - (random() * interval '30 days'),
    NOW() - (random() * interval '29 days'),
    NOW() - (random() * interval '28 days'),
    NOW() - (random() * interval '27 days')
FROM generate_series(1,1000);

-- 6. Order Items (avg 3 per order)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT o.order_id,
       (SELECT product_id FROM products ORDER BY random() LIMIT 1),
       (floor(random()*3)+1)::int,
       round((random()*150 + 20)::numeric,2)
FROM orders o, generate_series(1,3);

-- 7. Payments (1 per order)
INSERT INTO payments (order_id, amount, method)
SELECT order_id,
       total_amount,
       (ARRAY['cash','credit_card','wallet'])[floor(random()*3)+1]
FROM orders;

-- 8. Reviews (~50% of orders)
INSERT INTO reviews (order_id, rating, comment, created_at)
SELECT o.order_id,
       (floor(random()*5)+1)::int,
       (ARRAY[
         'Excellent food, fast delivery!',
         'Good but could be faster',
         'Average experience, food was cold',
         'Not satisfied, wrong order received',
         'Amazing taste, will order again!',
         'Very late delivery, not happy',
         'Great service and polite driver',
         'Too expensive for the portion size',
         'Delicious food, highly recommended!',
         'Packaging was poor, food spilled'
       ])[floor(random()*10)+1],
       NOW() - (random() * interval '30 days')
FROM orders o
WHERE random() < 0.5;
