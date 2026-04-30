select *
from {{ ref('fct_order_items') }}
where net_revenue <= 0