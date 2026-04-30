
{{
  config(
    materialized = 'table',
    schema='intermediate',
    alias='int_suppliers_with_nation',
    pre_hook=["{{audit_start(this.name,'intermediate')}}"],
    post_hook=["{{audit_success(this.name)}}"]
    )
}}




select S.S_SUPPKEY as  supplier_id ,
S.S_NAME as supplier_name ,
S.S_PHONE,
N.N_NAME  as NATION_NAME, 
R.R_NAME  AS REGION_NAME,
S.S_ACCTBAL  as account_balance

from {{ ref('stg_tpch__suppliers') }} s
inner join {{ ref('stg_tpch__nations') }} N
ON s.S_NATIONKEY = N.N_NATIONKEY
INNER JOIN {{ ref('stg_tpch__regions') }} R
ON N.N_REGIONKEY = R.R_REGIONKEY
