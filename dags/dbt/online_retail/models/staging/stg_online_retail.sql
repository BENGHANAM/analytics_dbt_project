{{
  config(
    materialized = 'table',
    schema = 'staging'
  )
}}

WITH source AS (
  SELECT
    TO_HEX(MD5(CONCAT(
      CAST(InvoiceNo AS STRING), '-',
      CAST(StockCode AS STRING), '-',
      CAST(InvoiceDate AS STRING), '-',
      CAST(Quantity AS STRING), '-',
      CAST(UnitPrice AS STRING)
    )))                                    AS sale_id,
    CAST(InvoiceNo AS STRING)              AS invoice_no,
    CAST(StockCode AS STRING)              AS stock_code,
    TRIM(Description)                      AS description,
    CAST(Quantity AS INT64)                AS quantity,
    CAST(InvoiceDate AS TIMESTAMP)         AS invoice_date,
    CAST(UnitPrice AS NUMERIC)             AS unit_price,
    CAST(CustomerID AS STRING)             AS customer_id,
    TRIM(Country)                          AS country,
    ROW_NUMBER() OVER (
      PARTITION BY
        InvoiceNo,
        StockCode,
        InvoiceDate,
        Quantity,
        CAST(UnitPrice AS NUMERIC),
        CustomerID
      ORDER BY InvoiceNo
    )                                      AS rn
  FROM {{ source('raw_data', 'online_retail') }}
  WHERE
    Quantity > 0
    AND UnitPrice >= 0
    AND CustomerID IS NOT NULL
)

SELECT
  sale_id,
  invoice_no,
  stock_code,
  description,
  quantity,
  invoice_date,
  unit_price,
  customer_id,
  country
FROM source
WHERE rn = 1