{{ config(
    schema='staging',
    materialized='view'
) }}

SELECT 
    PS_PARTKEY AS part_key,
    PS_SUPPKEY AS supplier_key,
    PS_AVAILQTY AS available_quantity,
    PS_SUPPLYCOST AS supply_cost,
    PS_COMMENT AS comment
FROM {{ source('tpch', 'partsupp') }}
