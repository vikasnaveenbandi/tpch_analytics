
{{
  config(
    materialized = 'incremental',
    unique_id = 'order_id',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]
    )
}}


with src_inc as (
select  *

from {{ ref('int_order_items') }}
 
{% if is_incremental() %}
  where order_date >= coalesce((select max(order_date) from {{ this }}), '1900-01-01')

{% endif %} 

)





 select
        order_id,
        CAST(customer_id AS STRING) AS customer_id,
        order_date,
        order_status,

        -- metrics
        sum(revenue) as net_revenue,
        count(*) as line_count

    from src_inc
  
    group by
        order_id,
        customer_id,
        order_date,
        order_status