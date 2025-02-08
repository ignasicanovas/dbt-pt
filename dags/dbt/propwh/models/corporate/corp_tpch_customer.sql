{{ config(
    materialized='incremental',
    unique_key='customer_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    customer_key,
    UPPER(TRIM(full_name)) AS full_name,  
    nation_key,  
    TRIM(phone) AS phone,  
    ROUND(account_balance, 2) AS account_balance,  
    COALESCE(marketing_segment, 'UNKNOWN') AS marketing_segment  
FROM {{ ref('stg_tpch_customer') }}

