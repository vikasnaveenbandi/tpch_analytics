
{{
  config(
    materialized = 'view',
    alias = 'stg_tpch__customer'
    )
}}

with src_stg_customer as (
select * 
from {{ source('tpch_src', 'customer') }} )

select 
C_CUSTKEY as customer_id,
C_NAME as cust_name,
C_ADDRESS as cust_Address,
C_NATIONKEY as cust_nation_key,
C_PHONE as cust_phone_number,
C_ACCTBAL as cust_account_balance,
C_MKTSEGMENT as cust_market_seg,
C_COMMENT as cust_comments

From src_stg_customer




