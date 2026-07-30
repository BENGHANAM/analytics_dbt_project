{{
config(
    materialized = 'table',
    schema = 'mart'
    )
}}

WITH customer_stats as(
SELECT 
    customer_id,
    country,
    count(DISTINCT invoice_no) AS total_orders,
    SUM(total_amount) AS total_spent,
    MIN(invoice_date_day) AS first_purchase_date,
    MAX(invoice_date_day) AS last_purchase_date,
    DATE_DIFF(
        MAX(invoice_date_day),
        MIN(invoice_date_day),
        DAY
        ) AS customer_lifetime_days,
    ROW_NUMBER() OVER (
    PARTITION BY customer_id
    ORDER BY COUNT(DISTINCT invoice_no) DESC
    ) AS rn
FROM {{ ref('fct_sales') }}
GROUP BY customer_id, country
)

SELECT
  customer_id,
  country,
  total_orders,
  total_spent,
  first_purchase_date,
  last_purchase_date,
  customer_lifetime_days
FROM customer_stats
WHERE rn = 1