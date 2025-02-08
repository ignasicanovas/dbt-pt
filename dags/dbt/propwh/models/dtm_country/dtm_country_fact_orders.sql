{{ config(
    materialized='incremental',
    schema=generate_schema_name('datamart', this),
    unique_key='order_key'
) }}


SELECT 

    CURRENT_TIMESTAMP() AS last_updated_at,
    o.order_key,
    o.customer_key,
    o.total_price,
    o.order_date,
    c.nation_key,
    n.nation_name,
    ROUND(o.total_price * 0.21, 2) AS tax_vat_21,
    ROUND(o.total_price * 1.21, 2) AS total_price_with_vat
    
FROM {{ ref('corp_tpch_orders') }} o
JOIN {{ ref('corp_tpch_customer') }} c ON o.customer_key = c.customer_key
JOIN {{ ref('corp_tpch_nation') }} n ON c.nation_key = n.nation_key
WHERE n.nation_name = '{{ var("nation_name") }}'


{% if is_incremental() %}
AND order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}

