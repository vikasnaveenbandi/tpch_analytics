
{{
  config(
    materialized = 'incremental',
    unique_id = 'order_id',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]
    )
}}

with orders as (

    select *
    from {{ ref('fct_orders') }}

),

customers as (

    select *
    from {{ ref('dim_customers') }}

),

joined as (

    select
        o.customer_id,
        o.order_id,
        o.net_revenue,

        c.cust_name as customer_name,
        c.nation,
        c.market_segment

    from orders o
    left join customers c
        on   md5(cast(o.customer_id as text)) = c.customer_id

),

aggregated as (

    select
        customer_id,
        customer_name,
        nation,
        market_segment,

        count(distinct order_id) as total_orders,
        sum(net_revenue) as total_revenue

    from joined
    group by 1,2,3,4

),

ranked as (

    select *,
        rank() over (order by total_revenue desc) as customer_rank

    from aggregated

)

select * from ranked