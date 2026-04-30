{{
  config(
    materialized = 'view',
    )
}}

select 
S_SUPPKEY,
S_NAME,
S_ADDRESS,
S_NATIONKEY,
S_PHONE,
S_ACCTBAL,
S_COMMENT

from {{ source('tpch_src', 'supplier') }}