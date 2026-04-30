{{
  config(
    materialized = 'view',
    alias = 'stg_tpch__lineitem'
    )
}}


with src_stg_lineitem as (
select * from
{{ source('tpch_src', 'lineitem') }}  )


select 

l_orderkey as line_order,
l_partkey as line_partkey,
l_suppkey as line_supllkey,
l_linenumber as line_linenumber,
l_quantity as line_quantity,
l_extendedprice as line_extendedprice,
l_discount as line_discount,
l_tax as line_tax,
l_returnflag as line_returnflag,
l_shipdate as line_shipdate,
l_commitdate as line_commit_date,
l_receiptdate as line_receiptdate,
l_shipinstruct as line_shipinstruct,
l_shipmode as line_shipmode,
l_comment as line_comment

 From src_stg_lineitem