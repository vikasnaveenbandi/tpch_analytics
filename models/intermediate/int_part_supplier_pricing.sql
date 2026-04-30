
{{
  config(
    materialized = 'table',
    schema = 'intermediate',
    alias = 'int_part_supplier_pricing',
    pre_hook = ["{{audit_start(this.name,'intermediate')}}"],
    post_hook = ["{{audit_success(this.name)}}"]
    )
}}


select 
p.p_partkey,
p.P_NAME,
su.PS_SUPPKEY,
sp.s_name,
su.ps_availqty,
su.ps_supplycost

from 
{{ ref('stg_tpch__part') }} p

inner join  {{ ref('stg_tpch__partsupp') }}  su 
on p.p_partkey = su.PS_PARTKEY
inner join  {{ ref('stg_tpch__suppliers') }}  sp
 on sp.S_SUPPKEY = su.PS_SUPPKEY