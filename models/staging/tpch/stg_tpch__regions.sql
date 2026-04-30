{{
  config(
    materialized = 'view',
    )
}}

select 
R_REGIONKEY,
R_NAME,
R_COMMENT

from {{ source('tpch_src', 'REGION') }}