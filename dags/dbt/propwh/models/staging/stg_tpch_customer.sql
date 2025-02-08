{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    C_CUSTKEY AS customer_key,
    C_NAME AS full_name,
    C_ADDRESS AS address,
    C_NATIONKEY AS nation_key,
    C_PHONE AS phone,
    C_ACCTBAL AS account_balance,
    C_MKTSEGMENT AS marketing_segment
FROM {{ source('tpch', 'customer') }}
