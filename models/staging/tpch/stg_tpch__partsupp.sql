
{{
  config(
    materialized = 'view',
    schema= 'STAGING',
    alias= 'stg_tpch__partsupp'
    )
}}



select 
PS_PARTKEY,
PS_SUPPKEY,
PS_AVAILQTY,
PS_SUPPLYCOST,
PS_COMMENT,
from {{ source('tpch_src', 'PARTSUPP') }}