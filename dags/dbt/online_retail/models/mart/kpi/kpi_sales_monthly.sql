SELECT
    invoice_year AS year,
    invoice_month_num as month,
    invoice_month as month_date,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT stock_code ) AS distinct_products,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_amount),2) AS total_revenue,
    ROUND(SAFE_DIVIDE(SUM(total_amount),COUNT(DISTINCT invoice_no)),2) AS average_order_value,
    ROUND(SAFE_DIVIDE(SUM(total_amount),COUNT(DISTINCT customer_id)),2) AS revenue_per_customer,
    COUNTIF(order_size_category = 'bulk') AS bulk_orders,
    COUNTIF(order_size_category = 'standard') as standard_orders,
    COUNTIF(order_size_category = 'small') AS small_orders
FROM {{ref('fct_sales')}}
GROUP BY 
    invoice_year,
    invoice_month_num,
    invoice_month
ORDER BY
invoice_year,
invoice_month_num