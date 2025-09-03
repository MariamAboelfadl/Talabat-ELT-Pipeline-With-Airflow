CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_restaurants` AS
SELECT 
    r.restaurant_id,
    r.name,
    r.cuisine,
    r.min_order,
    r.delivery_fee,
    r.is_open
FROM `ready-de27.talabat_dataset.restaurants` r
LEFT JOIN `ready-de27.talabat_dataset.users` u ON r.user_id = u.user_id

