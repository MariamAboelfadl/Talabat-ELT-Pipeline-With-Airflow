CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_customers` AS
SELECT 
    u.user_id AS customer_id,
    u.name,
    u.email,
    u.phone,
    u.created_at
FROM `ready-de27.talabat_dataset.users` u
WHERE u.user_type = 'customer';
