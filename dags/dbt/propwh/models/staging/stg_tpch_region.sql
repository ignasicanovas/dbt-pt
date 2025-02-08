{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    R_REGIONKEY AS region_key,
    R_NAME AS name,
    R_COMMENT AS comment
FROM {{ source('tpch', 'region') }}
