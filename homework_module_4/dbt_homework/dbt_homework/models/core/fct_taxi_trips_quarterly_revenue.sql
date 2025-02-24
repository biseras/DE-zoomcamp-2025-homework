{{
    config(
        materialized='table'
    )
}}
WITH trips_with_quarter AS (
    SELECT
        EXTRACT(YEAR FROM pickup_datetime) AS year,
        CASE
            WHEN EXTRACT(MONTH FROM pickup_datetime) IN (1, 2, 3, 4) THEN 'Q1'
            WHEN EXTRACT(MONTH FROM pickup_datetime) IN (5, 6, 7, 8) THEN 'Q2'
            WHEN EXTRACT(MONTH FROM pickup_datetime) IN (9, 10, 11, 12) THEN 'Q3'
        END AS quarter,
        total_amount
    FROM fct_taxi_trips
)

SELECT
    year,
    quarter,
    CONCAT(year, '/', quarter) AS year_quarter,
    SUM(total_amount) AS quarterly_revenue
FROM trips_with_quarter
GROUP BY year, quarter
ORDER BY year, quarter;