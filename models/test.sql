select  *
from 
DBT_DEV.staging.stg_tpch__orders a
inner join DBT_DEV.staging.stg_tpch__lineitem b
on a.order_id = b.line_order