{{
  config(
    materialized = 'table',
    schema='intermediate',
    alias='int_order_items',
    pre_hook=["{{audit_start(this.name,'intermediate') }}"],
    post_hook=["{{ audit_success(this.name) }}"]
    )
}}


select  a.order_id as order_id,
a.customer_id as  customer_id,
b.line_partkey as party_id,
b.line_supllkey as supplier_id,
b.line_quantity as quantity,
b.LINE_EXTENDEDPRICE as  LINE_EXTENDEDPRICE,
b.LINE_DISCOUNT as  LINE_DISCOUNT,
b.line_tax as line_tax,
b.LINE_LINENUMBER as line_number,
a.order_date as order_date,
a.order_status as order_status,
{{int_ord_revenue('b.LINE_EXTENDEDPRICE','b.LINE_DISCOUNT')}} as revenue
from 
{{ ref('stg_tpch__orders') }} a
inner join {{ ref('stg_tpch__lineitems') }} b
on a.order_id = b.line_order