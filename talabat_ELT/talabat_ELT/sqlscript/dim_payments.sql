CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_payments` AS
SELECT 
    p.payment_id,
    p.order_id,
    p.amount,
    p.method as payment_method,
    p.paid_at
FROM `ready-de27.talabat_dataset.payments` p;