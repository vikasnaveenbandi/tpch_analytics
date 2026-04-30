{{
  config(
    materialized = 'view',
    )
}}

select

P_PARTKEY as part_id , 
P_NAME as part_name,
P_MFGR as manufacturer ,
P_BRAND as brand,
P_TYPE as type,
P_SIZE as size,
P_CONTAINER as container,
P_RETAILPRICE,
P_COMMENT

from {{ source('tpch_src', 'PART') }}