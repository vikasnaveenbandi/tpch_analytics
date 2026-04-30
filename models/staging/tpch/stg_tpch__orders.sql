
{{
  config(
    materialized = 'view',
    alias = 'stg_tpch__orders'
    )
}}

with src_stg_orders as (
select * 
from  {{ source('tpch_src', 'ORDERS') }} 
)



select 
o_orderkey      as order_id,
o_custkey       as customer_id,
o_orderstatus   as order_status,
o_totalprice    as order_total_price,
o_orderdate     as order_date,
o_orderpriority as order_priority,
o_shippriority  as ship_priority,
o_comment       as order_comment
From src_stg_orders


