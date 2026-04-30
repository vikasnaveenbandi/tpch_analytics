{{
  config(
    materialized = 'view',
    )
}}

select 
N_NATIONKEY,
N_NAME,
N_REGIONKEY,
N_COMMENT

from {{ source('tpch_src', 'NATION') }}