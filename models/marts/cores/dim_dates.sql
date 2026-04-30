

{{ config(
    materialized='table',
    schema = 'marts',
    alias = 'dim_dates',

) }}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('1990-01-01')",
        end_date="to_date('2026-12-31')"
    ) }}

),

final as (

    select
    {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_id,
        date_day as date,

        -- basic breakdown
        extract(year from date_day) as year,
        extract(quarter from date_day) as quarter,
        extract(month from date_day) as month,
        extract(week from date_day) as week,

        extract(day from date_day) as day,
        extract(dayofweek from date_day) as day_of_week,

        -- names (optional but useful)
        to_char(date_day, 'MON') as month_name,
        to_char(date_day, 'DAY') as day_name,

        -- weekend flag
        case 
            when extract(dayofweek from date_day) in (0,6) then true
            else false
        end as is_weekend

    from date_spine

)

select * from final