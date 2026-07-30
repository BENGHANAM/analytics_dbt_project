SELECT * 
FROM {{ref('fct_sales')}}
WHERE quantity <= 0 