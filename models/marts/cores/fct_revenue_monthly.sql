
{{
  config(
    materialized = 'incremental',
    unique_id = 'order_id',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]
    )
}}

with order_items as (

    select * 
    from {{ ref('fct_order_items') }}

),

dates as (

    select *
    from {{ ref('dim_dates') }}

),

customers as (

    select *
    from {{ ref('dim_customers') }}

),

joined as (

    select
        oi.order_id,
        oi.customer_id,
        oi.order_date,
        oi.net_revenue,

        d.year,
        d.month,

        c.region,
        c.market_segment

    from order_items oi
    left join dates d
        on oi.order_date = d.date

    left join customers c
        on md5(cast(oi.customer_id as text))  = c.customer_id

),

final as (

    select
        year,
        month,
        region,
        market_segment,

        count(distinct order_id) as total_orders,

        sum(net_revenue) as total_net_revenue,

        sum(net_revenue) / nullif(count(distinct order_id), 0) as avg_order_value,

        count(distinct customer_id) as new_customers

    from joined
    group by 1,2,3,4

)

select * from final