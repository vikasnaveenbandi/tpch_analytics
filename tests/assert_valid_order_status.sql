select *
from {{ ref('fct_orders') }}
where order_status not in ('O', 'F', 'P')