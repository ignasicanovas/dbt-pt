{{ config(
    materialized='incremental',
    unique_key='nation_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    nation_key,
    UPPER(TRIM(name)) AS nation_name,  
    region_key,  
    TRIM(comment) AS nation_comment
FROM {{ ref('stg_tpch_nation') }}
