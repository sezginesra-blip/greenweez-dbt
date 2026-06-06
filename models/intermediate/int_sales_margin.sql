select 
    s.date_date,
    s.orders_id,
    s.products_id,
    s.revenue,
    s.quantity,
    s.quantity * p.purchase_price as purchase_cost,
    Round(s.revenue - (s.quantity * p.purchase_price),2) as margin
from {{ ref('stg_gz_sales') }} s
left join {{ ref('stg_gz_product') }} p 
on s.products_id = p.products_id
