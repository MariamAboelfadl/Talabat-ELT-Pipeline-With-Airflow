CREATE OR REPLACE TABLE `ready-de27.talabat_dataset.dim_date` AS
WITH dates AS (
  SELECT day
  FROM UNNEST(GENERATE_DATE_ARRAY('2020-01-01', CURRENT_DATE(), INTERVAL 1 DAY)) AS day
)
SELECT
  day AS date,
  EXTRACT(YEAR FROM day) AS year,
  EXTRACT(QUARTER FROM day) AS quarter,
  EXTRACT(MONTH FROM day) AS month,
  EXTRACT(DAY FROM day) AS day,
  EXTRACT(DAYOFWEEK FROM day) AS day_of_week,
  FORMAT_DATE('%A', day) AS weekday_name
FROM dates;
