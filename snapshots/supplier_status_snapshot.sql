{% snapshot supplier_status_snapshot %}

{{
   config(
       
       target_schema='snapshots',
       unique_key='supplier_id',

       strategy='check',
       check_cols=['region', 'nation']
   )
}}


select * From {{ ref('dim_suppliers') }}

{% endsnapshot %}