
{{ config(
    materialized='incremental',
    unique_key='part_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    part_key,
    UPPER(TRIM(name)) AS part_name,  
    UPPER(TRIM(manufacturer)) AS manufacturer,  
    UPPER(TRIM(brand)) AS brand,  
    UPPER(TRIM(type)) AS part_type,  
    size::INT AS size,
    UPPER(TRIM(container)) AS container,  
    ROUND(retail_price, 2) AS retail_price
FROM {{ ref('stg_tpch_part') }}
