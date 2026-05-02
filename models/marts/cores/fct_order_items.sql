
{{
  config(
    materialized = 'incremental',
    unique_id = 'order_id',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]
    )
}}

with src_fact_orders as (
select  *

from {{ ref('int_order_items') }}
 
{% if is_incremental() %}
  where order_date >= coalesce((select max(order_date) from {{ this }}), '1900-01-01')

{% endif %} 
)

,final as (

    select

        --  surrogate key 
        {{ dbt_utils.generate_surrogate_key(['order_id','line_number']) }} as order_item_key,

        order_id,
        CAST(customer_id AS STRING) AS customer_id,
        party_id,
        supplier_id,
        order_date,
        order_status,

        --line_number,
        quantity,

        -- 💰 revenue calculations
        line_extendedprice as gross_revenue,

        (line_extendedprice * line_discount) as discount_amount,

        (line_extendedprice * (1 - line_discount)) as net_revenue,

        (line_extendedprice * (1 - line_discount) * line_tax) as tax_amount

    from src_fact_orders

)

select * from final