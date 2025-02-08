{{ config(
    materialized='incremental',
    unique_key='supplier_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}

SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    supplier_key,
    UPPER(TRIM(name)) AS supplier_name,  
    TRIM(address) AS supplier_address,  
    nation_key,  
    TRIM(phone) AS phone,  
    ROUND(account_balance, 2) AS account_balance
FROM {{ ref('stg_tpch_supplier') }}
