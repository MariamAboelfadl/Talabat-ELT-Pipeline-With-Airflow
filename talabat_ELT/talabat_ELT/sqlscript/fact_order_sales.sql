CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.fact_order_sales` AS
SELECT 
    oi.order_item_id,
    o.order_id,
    c.customer_id,
    rstr.restaurant_id,
    d.driver_id,
    p.product_id,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS subtotal,
    DATE(o.created_at) AS order_date
FROM `ready-de27.talabat_dataset.order_items` oi
JOIN `ready-de27.talabat_dataset.orders` o 
    ON oi.order_id = o.order_id
JOIN `ready-de27.talabat_dataset.dim_customers` c 
    ON o.customer_id = c.customer_id
JOIN `ready-de27.talabat_dataset.dim_restaurants` rstr
    ON o.restaurant_id = rstr.restaurant_id
LEFT JOIN `ready-de27.talabat_dataset.dim_drivers` d
    ON o.driver_id = d.driver_id
JOIN `ready-de27.talabat_dataset.dim_products` p
    ON oi.product_id = p.product_id
JOIN `ready-de27.talabat_dataset.dim_date` dd
    ON dd.date = DATE(o.created_at);
