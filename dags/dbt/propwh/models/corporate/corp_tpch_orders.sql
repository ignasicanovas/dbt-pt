{{ config(
    materialized='incremental',
    unique_key='order_key'
) }}


SELECT 
    CURRENT_TIMESTAMP() AS last_updated_at,
    order_key,
    customer_key,
    UPPER(TRIM(order_status)) AS order_status,  
    ROUND(total_price, 2) AS total_price,  
    order_date::DATE AS order_date,  
    COALESCE(order_priority, 'STANDARD') AS order_priority,  
    TRIM(clerk) AS clerk,
    ship_priority::INT AS ship_priority,

    -- Cálculo del IVA (21%)
    ROUND(total_price * 0.21, 2) AS tax_vat_21,
    ROUND(total_price * 1.21, 2) AS total_price_with_vat,


    -- Validación dato
    CASE 
        WHEN ROUND(total_price * 0.21, 2) = tax_vat_21 THEN 1 
        ELSE 0 
    END AS tax_vat_21_valid

FROM {{ ref('stg_tpch_orders') }}

{% if is_incremental() %}
WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}
