{{ config(
    materialized='incremental',
    schema=generate_schema_name('datamart', this),
    unique_key='customer_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}

SELECT 
    c.customer_key,
    c.full_name,
    c.nation_key,
    n.nation_name,
    CURRENT_TIMESTAMP() AS last_updated_at
FROM {{ ref('corp_tpch_customer') }} c
JOIN {{ ref('corp_tpch_nation') }} n ON c.nation_key = n.nation_key
WHERE n.nation_name = '{{ var("nation_name") }}'
