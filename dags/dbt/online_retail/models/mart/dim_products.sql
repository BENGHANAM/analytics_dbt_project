{{
config(
    materialized = 'table',
    schema = 'mart'
    )
}}

SELECT DISTINCT
    stock_code,
    description,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity) AS  total_quantity_sold,
    ROUND(AVG(unit_price), 2) AS avg_unit_price,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM {{ ref('fct_sales')}}
GROUP BY stock_code, description
