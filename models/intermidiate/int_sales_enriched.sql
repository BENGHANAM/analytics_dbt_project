{{
    config(
        materialized = 'table',
        schema = 'staging'
    )
}}

SELECT 
    sale_id,
    invoice_no,
    stock_code,
    description,
    customer_id,
    invoice_date,
    Date(invoice_date)  AS invoice_date_day,
    DATE_TRUNC(DATE(invoice_date),MONTH) AS invoice_month,
    EXTRACT(YEAR FROM invoice_date) AS invoice_year,
    EXTRACT(MONTH FROM invoice_date) AS invoice_month_num,
    quantity,
    unit_price,
    ROUND(quantity * unit_price,2) AS total_amount,
    UPPER(TRIM(country)) AS country,
    CASE
        WHEN quantity >= 10 THEN 'bulk'
        WHEN quantity >=3 THEN 'standard'
        ELSE 'small'
    END  AS order_size_category

    FROM {{ref('stg_online_retail')}}
