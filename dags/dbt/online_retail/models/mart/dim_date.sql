{{
config(
    materialized = 'table',
    schema = 'mart'
    )
}}

SELECT DISTINCT
    invoice_date_day AS date_day,
    invoice_month as date_month,
    invoice_year as year,
    invoice_month_num as month_num,
    EXTRACT(QUARTER FROM invoice_date_day) AS quarter,
    FORMAT_DATE('%A', invoice_date_day) AS day_name,
    EXTRACT(DAYOFWEEK FROM invoice_date_day ) AS day_of_week,
    CASE
        WHEN EXTRACT (DAYOFWEEK FROM invoice_date_day) IN (1, 7)
        THEN TRUE ELSE FALSE 
    END AS is_weekend
    FROM {{ref('fct_sales')}}
    