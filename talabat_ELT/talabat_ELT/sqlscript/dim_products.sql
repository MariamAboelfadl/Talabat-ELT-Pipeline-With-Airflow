CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_products` AS
SELECT 
    p.product_id,
    p.restaurant_id,
    p.category,
    p.name,
    p.description,
    p.price,
    p.available
FROM `ready-de27.talabat_dataset.products` p;