{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    S_SUPPKEY AS supplier_key,
    S_NAME AS name,
    S_ADDRESS AS address,
    S_NATIONKEY AS nation_key,
    S_PHONE AS phone,
    S_ACCTBAL AS account_balance
FROM {{ source('tpch', 'supplier') }}
