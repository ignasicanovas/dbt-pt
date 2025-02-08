{{ config(
    materialized='incremental',
    schema=generate_schema_name('datamart', this),
    unique_key='supplier_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']
) }}

SELECT 
    s.supplier_key,
    s.nation_key,
    n.nation_name,
    s.account_balance,
    CURRENT_TIMESTAMP() AS last_updated_at
FROM {{ ref('corp_tpch_supplier') }} s
JOIN {{ ref('corp_tpch_nation') }} n ON s.nation_key = n.nation_key
WHERE n.nation_name = '{{ var("nation_name") }}'