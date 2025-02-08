{{ config(
    materialized='incremental',
    unique_key='order_item_key',
    incremental_strategy='merge',
    merge_exclude_columns=['last_updated_at']  

) }}



SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    {{ dbt_utils.generate_surrogate_key(['order_key', 'part_key', 'supplier_key','line_number']) }} AS order_item_key,
    order_key,
    part_key,
    supplier_key,
    line_number,
    quantity,
    ROUND(extended_price, 2) AS extended_price,  
    ROUND(discount, 4) AS discount,  
    ROUND(tax, 4) AS tax,
    UPPER(TRIM(return_flag)) AS return_flag,
    ship_date::DATE AS ship_date,
    commit_date::DATE AS commit_date,
    receipt_date::DATE AS receipt_date
FROM {{ ref('stg_tpch_lineitem') }}
