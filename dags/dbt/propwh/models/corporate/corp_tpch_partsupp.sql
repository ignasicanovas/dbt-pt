
{{ config(
    materialized='incremental',
    unique_key='part_supplier_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    {{ dbt_utils.generate_surrogate_key(['part_key', 'supplier_key']) }} AS part_supplier_key,
    part_key,
    supplier_key,
    available_quantity,
    ROUND(supply_cost, 2) AS supply_cost,
    TRIM(comment) AS comment
FROM {{ ref('stg_tpch_partsupp') }}
