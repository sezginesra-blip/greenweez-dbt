select
    o.date_date,
    o.orders_id,
    o.revenue,
    o.purchase_cost,
    o.margin,
    o.quantity,
    s.shipping_fee,
    s.log_cost,
    s.ship_cost,
    o.margin - s.shipping_fee - s.log_cost - s.ship_cost as operational_margin
from {{ ref('int_orders_margin') }} o
left join {{ ref('stg_gz_ship') }} s
on o.orders_id = s.orders_id
