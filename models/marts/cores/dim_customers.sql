{{ config(materialized='table',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]


) }}

select
     -- surrogate key
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} customer_id,
    CUST_NAME as CUST_NAME,
    CUST_MARKET_SEG as market_segment,
    nation_name as nation,
    region_name as region,
    CUST_ACCOUNT_BALANCE as account_balance

from {{ ref('int_customers_with_nation') }}