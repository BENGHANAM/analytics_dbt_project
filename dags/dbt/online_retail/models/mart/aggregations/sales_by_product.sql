SELECT 
    stock_code,
    description,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total_amount),2) AS total_revenue,
    ROUND(AVG(unit_price),2) AS avg_price
FROM {{ref('fct_sales')}}
GROUP BY stock_code,description
ORDER BY total_revenue DESC