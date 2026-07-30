{{
  config(
    materialized = 'incremental',
    schema = 'mart',
    unique_key = ['sale_id'],
    partition_by = {
      "field": "invoice_date",
      "data_type": "timestamp",
      "granularity": "day"
    },
    cluster_by = ["country", "customer_id"]
  )
}}

SELECT
  sale_id,
  invoice_no,
  stock_code,
  description,
  customer_id,
  invoice_date,
  invoice_date_day,
  invoice_month,
  invoice_year,
  invoice_month_num,
  quantity,
  unit_price,
  total_amount,
  country,
  order_size_category
FROM {{ ref('int_sales_enriched') }}

{% if is_incremental() %}
  WHERE invoice_date > (SELECT MAX(invoice_date) FROM {{ this }})
{% endif %}