
{{ config(materialized='table',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]


) }}

select
    --{{ dbt_utils.generate_surrogate_key(['part_id']) }} as part_key,
{{ dbt_utils.generate_surrogate_key(['part_id']) }}  as  part_key,
    part_id,
    part_name as name,
    manufacturer,
    brand,
    type,
    size,
    container

from {{ ref('stg_tpch__part') }}