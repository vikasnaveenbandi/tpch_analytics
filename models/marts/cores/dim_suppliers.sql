

{{ config(materialized='table',
    pre_hook = ["{{audit_start(this.name,'marts')}}"],
    post_hook = ["{{audit_success(this.name)}}"]


) }}

select
    {{ dbt_utils.generate_surrogate_key(['supplier_id']) }} as supplier_key,

    supplier_id,
    supplier_name as name,
    nation_name as nation,
    region_name as region,
    account_balance

from {{ ref('int_suppliers_with_nation') }}