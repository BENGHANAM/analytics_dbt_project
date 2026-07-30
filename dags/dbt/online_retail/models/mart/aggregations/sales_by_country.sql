SELECT 
    country,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount),2) AS total_revenue
FROM {{ref('fct_sales')}}
GROUP BY country
ORDER BY total_revenue DESC