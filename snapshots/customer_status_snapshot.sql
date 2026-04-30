{% snapshot customer_status_snapshot  %}

{{
   config(
      
       target_schema='snapshots',
       unique_key='customer_id',

       strategy='check',
       check_cols=['market_segment', 'nation']
   )
}}

select *
from {{ ref('dim_customers') }}

{% endsnapshot %}