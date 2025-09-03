CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.fact_reviews` AS
SELECT 
    r.review_id,
    r.order_id,
    c.customer_id,
    d.driver_id,
    rstr.restaurant_id,
    r.rating,
    r.comment,
    r.created_at
FROM `ready-de27.talabat_dataset.reviews` r
JOIN `ready-de27.talabat_dataset.orders` o 
    ON r.order_id = o.order_id
JOIN `ready-de27.talabat_dataset.dim_customers` c 
    ON o.customer_id = c.customer_id
JOIN `ready-de27.talabat_dataset.dim_restaurants` rstr
    ON o.restaurant_id = rstr.restaurant_id
LEFT JOIN `ready-de27.talabat_dataset.dim_drivers` d 
    ON o.driver_id = d.driver_id
JOIN `ready-de27.talabat_dataset.dim_date` dd
    ON dd.date = DATE(r.created_at);

