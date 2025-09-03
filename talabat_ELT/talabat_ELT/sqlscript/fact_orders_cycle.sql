CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.fact_orders_cycle` AS
SELECT 
    o.order_id,
    c.customer_id,
    rstr.restaurant_id,
    d.driver_id,
    o.status,
    o.created_at,
    o.accepted_at,
    o.picked_up_at,
    o.delivered_at,
    o.total_amount,
    COUNT(oi.order_item_id) AS item_count
FROM `ready-de27.talabat_dataset.orders` o
LEFT JOIN `ready-de27.talabat_dataset.order_items` oi 
    ON o.order_id = oi.order_id
JOIN `ready-de27.talabat_dataset.dim_customers` c 
    ON o.customer_id = c.customer_id
JOIN `ready-de27.talabat_dataset.dim_restaurants` rstr 
    ON o.restaurant_id = rstr.restaurant_id
LEFT JOIN `ready-de27.talabat_dataset.dim_drivers` d 
    ON o.driver_id = d.driver_id
JOIN `ready-de27.talabat_dataset.dim_date` dd
    ON dd.date = DATE(o.created_at)

GROUP BY 
    o.order_id, c.customer_id, rstr.restaurant_id, d.driver_id,
    o.status, o.created_at, o.accepted_at, o.picked_up_at, 
    o.delivered_at, o.total_amount;

