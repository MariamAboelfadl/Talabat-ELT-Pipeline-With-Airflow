CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_drivers` AS
SELECT 
    d.driver_id,
    d.vehicle_type,
    d.license_number,
    d.is_active,
    d.rating_avg,
    u.name,
    u.phone
FROM `ready-de27.talabat_dataset.drivers` d
JOIN `ready-de27.talabat_dataset.users` u ON d.user_id = u.user_id;
