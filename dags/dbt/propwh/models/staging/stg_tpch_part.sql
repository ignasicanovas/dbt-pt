{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    P_PARTKEY AS part_key,
    P_NAME AS name,
    P_MFGR AS manufacturer,
    P_BRAND AS brand,
    P_TYPE AS type,
    P_SIZE AS size,
    P_CONTAINER AS container,
    P_RETAILPRICE AS retail_price
FROM {{ source('tpch', 'part') }}
