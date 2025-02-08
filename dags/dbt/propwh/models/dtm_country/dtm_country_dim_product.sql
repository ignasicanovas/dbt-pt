{{ config(
    materialized='incremental',
    schema=generate_schema_name('datamart', this),
    unique_key='part_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}

SELECT 
    p.part_key,
    p.part_name AS product_name,
    p.retail_price,
    CURRENT_TIMESTAMP() AS last_updated_at
FROM {{ ref('corp_tpch_part') }} p

{% if is_incremental() %}
WHERE p.part_key NOT IN (SELECT part_key FROM {{ this }})
{% endif %}
