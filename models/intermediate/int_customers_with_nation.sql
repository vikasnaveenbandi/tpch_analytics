

{{
  config(
    materialized = 'table',
    schema='intermediate',
    alias='int_customers_with_nation',
    pre_hook=["{{audit_start(this.name,'intermediate')}}"],
    post_hook=["{{audit_success(this.name)}}"]
    )
}}




select c.customer_id ,
C.CUST_NAME,
C.CUST_PHONE_NUMBER,
N.N_NAME  as NATION_NAME, 
R.R_NAME  AS REGION_NAME,
c.CUST_ACCOUNT_BALANCE,
c.CUST_MARKET_SEG

from {{ ref('stg_tpch__customer') }} c
inner join {{ ref('stg_tpch__nations') }} N
ON C.CUST_NATION_KEY = N.N_NATIONKEY
INNER JOIN {{ ref('stg_tpch__regions') }} R
ON N.N_REGIONKEY = R.R_REGIONKEY
