{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    N_NATIONKEY AS nation_key,
    N_NAME AS name,
    N_REGIONKEY AS region_key,
    N_COMMENT AS comment
FROM {{ source('tpch', 'nation') }}
