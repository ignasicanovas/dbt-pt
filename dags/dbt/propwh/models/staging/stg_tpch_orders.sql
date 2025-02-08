{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    O_ORDERKEY AS order_key,
    O_CUSTKEY AS customer_key,
    O_ORDERSTATUS AS order_status,
    O_TOTALPRICE AS total_price,
    O_ORDERDATE AS order_date,
    O_ORDERPRIORITY AS order_priority,
    O_CLERK AS clerk,
    O_SHIPPRIORITY AS ship_priority
FROM {{ source('tpch', 'orders') }}
