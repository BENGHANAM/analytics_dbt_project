SELECT
    COUNT(*) AS total_sales_lines,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT stock_code) AS distinct_product,
    COUNT(DISTINCT country) AS distinct_countries,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_amount),2) AS total_revenue,
    ROUND(AVG(total_amount),2) AS avg_line_amount,
    ROUND(SAFE_DIVIDE(SUM(total_amount),COUNT(DISTINCT invoice_no)),2) AS average_order_value,
    ROUND (SAFE_DIVIDE(SUM(total_amount),COUNT(DISTINCT customer_id)),2) AS revenue_per_customer,
    MIN(invoice_date_day) AS first_sale_date,
    MAX(invoice_date_day) AS last_sale_date,
    DATE_DIFF(MAX(invoice_date_day),MIN(invoice_date_day),DAY) AS active_days
FROM {{ ref('fct_sales')}}