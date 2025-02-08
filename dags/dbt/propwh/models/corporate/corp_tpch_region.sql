{{ config(
    materialized='incremental',
    unique_key='region_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    region_key,
    UPPER(TRIM(name)) AS region_name,  
    TRIM(comment) AS region_comment
FROM {{ ref('stg_tpch_region') }}
    